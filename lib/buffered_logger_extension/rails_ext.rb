ActiveSupport::BufferedLogger.class_eval do

  def level_to_s(level)
    ['DEBUG','INFO','WARN','ERROR','FATAL','UNKNOWN'][level]
  end

  def add(severity, message = nil, progname = nil, &block)
    return if @level > severity
    message = (message || (block && block.call) || progname).to_s
    # If a newline is necessary then create a new message ending with a newline.
    # Ensures that the original message is not mutated.
    message = "#{message}\n" unless message[-1] == ?\n
    buffer << format_message(severity, Time.now, progname, message)
    auto_flush
    message
  end

  def format_message(severity, timestamp, progname, msg)
    pattern = Regexp.new("^#{Rails.root}")
    location = (Kernel.caller.detect{|c| c.match(pattern)} || '').split("/")[-1]
    stack = (severity > 1 && severity < 4) ? Kernel.caller(3).collect{|c| "   " + c}.join("\n") + "\n" : ''
    "[#{timestamp.strftime("%Y-%m-%d %H:%M:%S %Z")}] #{level_to_s(severity)} #{location} #{msg}#{stack}"
  end

end
