#!/usr/bin/ruby

# why is this ruby? no particular reason, beyond that it meant I had to write
# some ruby; using this to keep my lacie attached devices from spinning down (and
# thus becoming detached) under OS X 10.8.5

require 'yaml'

# ~/.toucher.yaml:
# --- # files to touch
# - /Volumes/Backup/.toucher
# - /Volumes/Left/.toucher

# atubbs.disk.Toucher.plist:
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
#     <key>Label</key>
#     <string>atubbs.disk.Toucher</string>
#     <key>Program</key>
#     <string>/Users/atubbs/scripts/toucher.rb</string>
#     <key>LowPriorityIO</key>
#     <true/>
#     <key>Nice</key>
#     <integer>1</integer>
#     <key>WorkingDirectory</key>
#     <string>/Users/atubbs</string>
#     <key>RunAtLoad</key>
#     <false/>
#     <key>UserName</key>
#     <string>atubbs</string>
#     <key>StartInterval</key>
#     <integer>300</integer>
# </dict>
# </plist>

CONFIGFILE = ENV['HOME'] + '/.toucher.yaml'
if not File.exists?(CONFIGFILE)
  exit
end
File.open(CONFIGFILE) { |yf| YAML::load(yf) }.each { |touchfile| File.open(touchfile, 'w') { |file| file.write(Time.now.getutc) } }
