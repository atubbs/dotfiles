#!/usr/bin/ruby

require 'yaml'

# ~/.toucher.yaml:
# --- # files to touch
# - /Volumes/Backup/.toucher
# - /Volumes/Left/.toucher

CONFIGFILE = ENV['HOME'] + '/.toucher.yaml'
if not File.exists?(CONFIGFILE)
  exit
end
File.open(CONFIGFILE) { |yf| YAML::load(yf) }.each { |touchfile| File.open(touchfile, 'w') { |file| file.write(Time.now.getutc) } }
