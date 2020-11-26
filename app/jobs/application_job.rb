class ApplicationJob < ActiveJob::Base
  p "applcationjob start"
     MailSendStaffJob.perform_later
     SycCrw01CmToGrossCust.perform_later
end
