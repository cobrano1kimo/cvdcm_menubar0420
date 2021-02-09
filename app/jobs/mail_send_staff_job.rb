class MailSendStaffJob < ActiveJob::Base


  p "MailSendStaffJob"

  queue_as :default

  def perform
          scheduler = Rufus::Scheduler.new
           #scheduler.cron '30 08,16 * * *' do |x|
           scheduler.cron '30 12 * * *' do |x|
            UserMailer.welcome_email().deliver_now
         end
    end
  end
