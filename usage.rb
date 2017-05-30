require_relative 'wob'

require 'pry'
binding.pry

# ~/Code/personal/wob (master)$ ruby usage.rb

# From: /home/drusepth/Code/personal/wob/usage.rb @ line 3 :

#     1: require_relative 'wob'
#     3: require 'pry'
#  => 4: binding.pry

# [1] pry(main)> wob.fib(7)
# [INFO] Looking up new method for method fib taking arguments [7].
# [DEBUG] Checking found source code for viability.
# [DEBUG] Code doesn't throw an exception!
# [INFO] Saving wob_modules/fib.rb cache for future invocations.
# [INFO] Defining fib in the global scope with 1 arguments passed.
# [DEBUG] Executing method fib...
# => 13
# [2] pry(main)> wob.fib(7)
# => 13
# [3] pry(main)> fib(7)
# => 13
# [4] pry(main)> fib(8)
# => 21
