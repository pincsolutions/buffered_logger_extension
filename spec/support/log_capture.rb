class LogCapture
  def LogCapture.open
    return self
  end

  def LogCapture.write(data)
    @@last_message = data
  end

  def LogCapture.last_message
    @@last_message
  end
end