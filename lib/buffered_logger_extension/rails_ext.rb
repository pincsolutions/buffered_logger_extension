ActiveSupport::BufferedLogger.class_eval do

  def level_to_s(level)
    ['DEBUG','INFO','WARN','ERROR','FATAL','UNKNOWN'][level]
  end

  # to show a variable name and value, use a block like {"a"}.  Otherwise, this will just print the result of the block.
  def show_block(blk)
    var_name = blk.call
    var_val = eval(var_name, blk.binding).inspect
    "#{var_name}: #{var_val}"
  rescue
    blk.call
  end

  def add(severity, message = nil, progname = nil, &block)
    return if @level > severity
    block_msg = block ? show_block(block) : ""
    message = "#{message.to_s} #{block_msg} #{progname.to_s}"
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
