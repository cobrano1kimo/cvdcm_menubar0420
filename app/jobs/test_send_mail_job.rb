class TestSendMailJob < ActiveJob::Base
  queue_as :default

  def perform
          scheduler = Rufus::Scheduler.new
           #scheduler.cron '30 08,16 * * *' do |x|
           scheduler.cron '*/1 * * * *' do |x|
          TestMailer.test_email().deliver_now
         end
    end
end
