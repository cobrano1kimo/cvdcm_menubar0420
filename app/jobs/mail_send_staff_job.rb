class MailSendStaffJob < ActiveJob::Base


  p "MailSendStaffJob"

  queue_as :default

  def perform
          scheduler = Rufus::Scheduler.new
            scheduler.cron '45 06,12,16 * * *' do |x|
           #scheduler.cron '*/5 * * * *' do |x|
            UserMailer.welcome_email().deliver_now
         end
    end
  end
