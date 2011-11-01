class TestLogging

  def initialize(logger)
    @logger = logger
  end

  def fake_log
    @logger.error("Nothing went wrong, I swear!")
  end

  def cause_a_stack_trace
    @logger.warn("Something is happening, I know it.")
  end
  # new stuff to be added here. Previous methods require that the line numbers remain the same for the tests to pass (yes, brittle, I know)
end