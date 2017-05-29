class Wob
  CODE_REPOSITORY = 'https://www.github.com/drusepth/wob'

  def method_missing(method_name, *arguments, &block)
    raise "NotImplemented: wob instance methods"
  end

  def self.method_missing(method_name, *arguments, &block)
    log "Looking up new method for method #{method_name} taking arguments #{arguments.inspect}."
  end

  private

  def self.log message, channel: nil
    puts "[#{channel || 'INFO'}] #{message}"
  end
end

def wob; Wob; end