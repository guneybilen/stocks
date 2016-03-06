# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, "development"
 
# every :weekend, :at => "20:00, 21:00, 22:00, 23:00, 24:00"  do 
#   rake "load_page"
# end

every :weekday, :at => "08:00, 09:00, 10:00, 11:00, 12:00, 13:00, 14:00, 15:00, 16:00"  do 
  rake "load_page"
end