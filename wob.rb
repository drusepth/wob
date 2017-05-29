class Wob
  CODE_REPOSITORY = 'https://www.github.com/drusepth/wob'
  LOCAL_DIRECTORY = 'wob_modules'

  class PotentialSourceCodeEnumerator
    # should go fetch some source code, then fork off to continue finding more potential source codes and return the first code found for checking
    # when code is accepted, we should terminate the search thread
  end

  # Initialize the Wob context with all previously-injected methods
  Dir["#{LOCAL_DIRECTORY}/*.rb"].each { |file| require file }

  def method_missing method_name, *arguments, &block
    raise "NotImplemented: wob instance methods"
  end

  def self.method_missing method_name, *arguments, &block
    log "Looking up new method for method #{method_name} taking arguments #{arguments.inspect}."
    new_method_source_code = find_method method_name, arguments

    log "Checking found source code for viability.", channel: :debug
    while !usable_source_code? new_method_source_code
      #new_method_source_code =
    end
  end

  private

  def self.log message, channel: nil
    puts "[#{(channel || 'INFO').upcase}] #{message}"
  end

  def self.find_method method_name, *arguments
    #todo actually do the googlez
    -> (*arguments) { puts "#{method_name} was called!" }
  end

  def self.store_method method_name, method_source_with_signature
    Dir.mkdir(LOCAL_DIRECTORY) unless File.exists?(LOCAL_DIRECTORY)
    File.open("#{LOCAL_DIRECTORY}/#{method_name.downcase}.rb", 'w') { |f| f.write method_source_with_signature }
  end

  def self.usable_source_code? source_code
    eval source_code
    true
  rescue
    false
  end
end

def wob; Wob; end