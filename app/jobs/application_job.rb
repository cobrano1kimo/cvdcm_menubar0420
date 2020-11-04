class ApplicationJob < ActiveJob::Base
  p "applcationjob start"

    MailSendStaffJob.perform_later 1,'*/1 * * * *','N'

end
