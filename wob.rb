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
      #new_method_source_code = next_source_code_in_worker_enumerator
    end
    log "Source code executes!"

    log "Storing source code in #{LOCAL_DIRECTORY}/ cache..."
    store_method method_name, new_method_source_code

    log "Injecting method into global scope for future invocations..."
    TOPLEVEL_BINDING.eval('self').send(:define_method, method_name, -> (*arguments) { eval new_method_source_code })
  end

  private

  def self.log message, channel: nil
    puts "[#{(channel || 'INFO').upcase}] #{message}"
  end

  def self.find_method method_name, *arguments
    #todo actually do the googlez

    #todo redirect STDOUT/STDERR to log:debug and log:error
    found_source_code = 'puts "some source code"'
  end

  def self.store_method method_name, method_source_with_signature
    Dir.mkdir(LOCAL_DIRECTORY) unless File.exists?(LOCAL_DIRECTORY)
    File.open("#{LOCAL_DIRECTORY}/#{method_name.downcase}.rb", 'w') { |f| f.write method_source_with_signature }
  end

  def self.usable_source_code? source_code
    eval source_code
    true
  rescue Exception => e
    log "Caught exception when testing source code: #{e.inspect}", channel: :error
    false
  end
end

def wob; Wob; end