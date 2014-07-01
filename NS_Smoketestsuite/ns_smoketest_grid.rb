require 'fileutils'
def stringReplace(searchString, replaceString, fileName)
  aFile = File.open(fileName, "r")
  aString = aFile.read
  aFile.close
  aString.gsub!(searchString, replaceString)
  File.open(fileName, "w") { |file| file << aString }
end

supported_route = ["mfa_direct", "mfa_fsg", "mbl_direct", "mbl_fsg", "e2e"]
# set up reports head directory to house all reports and artifacts
parent_directory = Dir.getwd
results_head_directory = "#{parent_directory}/Reports"

# cleanup reports directory
if (File.directory?(results_head_directory))
  FileUtils.rm_rf(results_head_directory)
  Dir.mkdir(results_head_directory)
else
  Dir.mkdir(results_head_directory)
end

# abort if routes are not passed to the grid
if ARGV.length == 0
  abort("Aborting.  Route not specified.")
else

  ARGV.each do |tag|
    if !supported_route.include? tag
      abort("Aborting.  Unsupported route: #{tag}")
    end
    route_dir="#{results_head_directory}/Reports_#{tag}"
    Dir.mkdir(route_dir)
  end

  # loop through each route
  ARGV.each do |tag|
    route_directory="#{results_head_directory}/Reports_#{tag}"
    resultsfile="#{route_directory}/Automation_Report_#{tag}.html"
    logfile="#{route_directory}/Automation_Log_#{tag}.log"
    ENV['SCREENSHOT_PATH'] = "#{route_directory}/"
    puts "Initiating test thread for route #{tag}"
    ENV["ROUTE"]=tag
    system("calabash-android resign 9901.apk")
    system("calabash-android run 9901.apk -v --tags @#{tag} --format html --out  #{resultsfile} >> #{logfile} &")

    # Thread monitor
    run_status="In progress"
    counter=0
    while run_status=="In progress"
      if counter==0
        puts "Initiating thread monitor...."
      end
      sleep 5
      process_count=`ps -ef | grep cucumber | wc -l`
      iprocess_count=Integer(process_count)
      if iprocess_count < 3
        run_status="Completed"
        puts "Test execution completed"
      else
        puts "Thread monitor .... #{iprocess_count-1} running"
      end
      counter += 1
    end

  end

  # Finalize reports
  puts "Preparing reports...."
  ARGV.each do |tag|
    route_directory="#{results_head_directory}/Reports_#{tag}"
    resultsfile="#{route_directory}/Automation_Report_#{tag}.html"
    logfile="#{route_directory}/Automation_Log_#{tag}.log"
    reporttime=Time.now
    stringReplace("Cucumber Features", "<font size='2'>IFS Mobile Automation Result | Report Time: #{reporttime} | <a href='#{logfile}'>View Automation Log</a></font>", "#{resultsfile}")
    stringReplace("#{route_directory}/", "", "#{resultsfile}")
  end
  puts "Report preparation completed"

end

