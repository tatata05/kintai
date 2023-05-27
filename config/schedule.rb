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

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '9:00 am' do
  rake "shift_check:shift_check_approval_pending"
end

every 1.day, at: '9:00 am' do
  rake "absence_check:absence_check_approval_pending"
end

every '0 0 20 * *' do
  rake "shift_applied_check:shift_applied"
end

every 1.month, at: 'start of the month at 0am' do
  rake "notification_destroy:destroy_unapplied"
end
