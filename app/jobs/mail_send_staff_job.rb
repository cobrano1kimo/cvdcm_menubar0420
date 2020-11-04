class MailSendStaffJob < ApplicationJob


  p "MailSendStaffJob"

  queue_as :low_priority

  def perform(*guests,cronmode,stopmark)
       scheduler = Rufus::Scheduler.new
      scheduler.cron(cronmode) do
      UserMailer.welcome_email().deliver_now
      end
    end
  end
