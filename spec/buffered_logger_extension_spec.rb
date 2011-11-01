require_relative "./spec_helper"

describe BufferedLoggerExtension do
  before :each do
    @buflog = ActiveSupport::BufferedLogger.new(LogCapture, 0)
  end

  it "does not break the logger " do
    @buflog.info("Yes, the logger is still working, YAY!!!")
    logged = LogCapture.last_message
    logged.should_not be_nil
    logged.should include("Yes, the logger is still working")
  end

  it "adds a timestamp to the front of the log message" do
    curdate = Date.today
    @buflog.info("There should be a timestamp here")
    LogCapture.last_message.should include(curdate.strftime("%Y-%m-%d"))
  end

  it "adds the severity to the log message" do
    @buflog.info("This is just a note")
    LogCapture.last_message.should include("INFO")

    @buflog.debug("This one is for the programmers")
    LogCapture.last_message.should include("DEBUG")

    @buflog.error("Oops, something went wrong")
    LogCapture.last_message.should include("ERROR")

    @buflog.warn("Just letting you know, in case you might care")
    LogCapture.last_message.should include("WARN")
  end
  
  it "adds the file name and line number to the message" do
    t = TestLogging.new(@buflog)
    t.fake_log
    LogCapture.last_message.should include("test_logging.rb:8")
  end
end