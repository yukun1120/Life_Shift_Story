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

every :day, at: '0:00am' do
  runner "User.find_each { |user| FamousQuote.update_random_quote_for_user(user) }"
end

every :day, at: '0:00am' do
  runner "User.find_each { |user| Tagline.update_random_tagline_for_user(user) }"
end

every :day, at: '12:00am' do
  runner "Reflection.update_all(completed: false)"
end

every :day, at: '12:00am' do
  runner "Good.update_all(confirmed: false)"
end

every :day, at: '0:00am' do
  runner "Habit.reset_checks"
end








