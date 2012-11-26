require 'irb/completion'         # activate default completion
require 'irb/ext/save-history'   # activate default history
require 'tempfile'               # used for Vim integration

# save history using built-in options
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
puts 'History configured.'

# auto-indent
IRB.conf[:AUTO_INDENT]=true
puts 'Auto-indent on.'

# try to load rubygems
begin
   require 'rubygems'
   puts 'Rubygems loaded.'
rescue LoadError => e
   puts "Seems you don't have Rubygems installed: #{e}"
end

# configure vim
@irb_temp_code = nil

def vim(file=nil)
   file = file || @irb_temp_code || Tempfile.new('irb_tempfile').path+'.rb'
   system("vim #{file}")
   if(File.exists?(file) && File.size(file)>0)
      Object.class_eval(File.read(file))
      @irb_temp_code = file
      'File loaded from Vim.'
   else
      'No file loaded.'
   end
rescue => e
   puts "Error on vim: #{e}"
end
puts 'Vim available.'

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !defined?(RAILS_DEFAULT_LOGGER)
 require 'logger'
 RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end
