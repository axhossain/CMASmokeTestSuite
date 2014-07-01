# file utilities
require "fileutils"

def stringReplace(searchString, replaceString, fileName)
  aFile = File.open(fileName, "r")
  aString = aFile.read
  aFile.close
  aString.gsub!(searchString, replaceString)
  File.open(fileName, "w") { |file| file << aString }
end

# supported FI tags
# credentials defined in the hooks.rb file
supported_fi = ["9901", "1000"]

# set up reports head directory to house all reports and artifacts
parent_directory = Dir.getwd
results_head_directory = "#{parent_directory}/Reports"

# set up environment variable for screen capture
ENV['SCREENSHOT_VIA_USB']="true"

#initialize test server port
test_server_port=36000

# cleanup reports directory
if (File.directory?(results_head_directory))
  FileUtils.rm_rf(results_head_directory)
  Dir.mkdir(results_head_directory)
else
  Dir.mkdir(results_head_directory)
end

# abort if FI tags are not passed to the grid
if ARGV.length == 0
  abort("Aborting.  FI tag not specified.")
else

  # check and abort if all required apk's are not found in the parent directory
  ARGV.each do |tag|
    apk_file_path = "#{parent_directory}/#{tag}.apk"

    if !supported_fi.include? tag
       abort("Aborting.  Unsupported FI tag: #{tag}")
    end

    if (File.exist?(apk_file_path))
      # create sub-report directory for each FI tag under report head directory
      Dir.mkdir("#{results_head_directory}/Reports_#{tag}")
      # resign apk
      puts "Resigning #{tag}.apk"
      system("calabash-android resign #{tag}.apk")
    else
      abort("Aborting.  #{tag}.apk not found.")
    end

  end

  # loop through each FI tag
  ARGV.each do |tag|

    # detect available devices
    devices = `adb devices`

    # push unique device serial numbers into the array
    @serialno = []
    omitter = 0
    devices.split("\n").each do |entry|
      if omitter > 0
        @serialno.push(entry.split("\t").first)
      end
      omitter += 1
    end

    # abort if no devices are detected
    if @serialno.length == 0
      abort("Aborting.  No android devices found.")
    else
      puts "Starting tests for FI #{tag}"
    end

    # loop through each device and start the tests with 15 seconds delay
    loop_counter=1
    last_device_flag=false

    @serialno.each do |device|

      if loop_counter==@serialno.length
        last_device_flag=true
      end
      loop_counter +=1

      # manage test servers for each device
      ENV['TEST_SERVER_PORT'] = test_server_port.to_s
      test_server_port += 1

      # create sub-report directory for the device under each FI sub-report directory
      device_directory="#{results_head_directory}/Reports_#{tag}/#{device}"
      Dir.mkdir(device_directory)

      # set up variables to archive device specific artifacts
      ENV['SCREENSHOT_PATH'] = "#{device_directory}/"
      propsfile="#{device_directory}/#{device}_Properties.txt"
      resultsfile="#{device_directory}/Automation_Report_#{device}.html"
      logfile="#{device_directory}/Automation_Log_#{device}.log"

      # read device properties and write to the properties file
      `adb -s #{device} -e shell getprop > #{propsfile}`

      # initiate test on the device
      puts "Initiating test thread on device #{device}"
      system("calabash-android run #{tag}.apk -v ADB_DEVICE_ARG='#{device}' --tags @#{tag} --format html --out  #{resultsfile} >> #{logfile} &")
      puts "Reinstalling the application and the test server on device #{device}"

      if !last_device_flag
        puts"waiting 30 seconds before starting the test on the next device"
        sleep 30
      end
    end

    # Thread monitor
    run_status="In progress"
    counter=0
    while run_status=="In progress"
      if counter==0
        puts "Initiating thread monitor...."
      end
      sleep 10
      process_count=`ps -ef | grep cucumber | grep TEST_SERVER_PORT | wc -l`
      iprocess_count=Integer(process_count)
      if iprocess_count < 2
        run_status="Completed"
        puts "Test execution completed"
      else
        puts "Thread monitor .... #{iprocess_count-1} running"
      end
      counter += 1
    end

    # Finalize reports
    puts "Preparing reports...."
    @serialno.each do |device|
      device_directory="#{results_head_directory}/Reports_#{tag}/#{device}"
      propsfile="#{device_directory}/#{device}_Properties.txt"
      resultsfile="#{device_directory}/Automation_Report_#{device}.html"
      logfile="#{device_directory}/Automation_Log_#{device}.log"
      adblogfile="ADB_Log_#{device}.log"
      system("mv #{adblogfile} #{device_directory}")
      devicemodel = `adb -s #{device} -e shell getprop ro.product.model`
      deviceosver = `adb -s #{device} -e shell getprop ro.build.version.release`
      reporttime=Time.now
      stringReplace("Cucumber Features", "<font size='2'>IFS Mobile Automation Result | Report Time: #{reporttime} | Test Device: #{devicemodel} | Android: #{deviceosver} | Serial: #{device}<br><a href='#{propsfile}'>View Device Properties</a> | <a href='#{logfile}'>View Automation Log</a> | <a href='#{adblogfile}'>View ADB Device Log</a> </font>", "#{resultsfile}")
      stringReplace("#{device_directory}/", "", "#{resultsfile}")
    end
    puts "Report preparation completed"
  end
end

