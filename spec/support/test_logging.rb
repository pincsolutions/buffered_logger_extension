class TestLogging

  def initialize(logger)
    @logger = logger
  end

  def fake_log
    @logger.error("Nothing went wrong, I swear!")
  end

  # new stuff to be added here. Previous method requires that the line number remain the same (brittle, I know)
end