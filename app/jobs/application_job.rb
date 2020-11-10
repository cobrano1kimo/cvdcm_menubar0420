class ApplicationJob < ActiveJob::Base
  p "applcationjob start"

    # MailSendStaffJob.perform_later 30,'0 23,3,6,9 * * *'

end
