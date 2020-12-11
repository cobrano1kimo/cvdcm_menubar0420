class ApplicationJob < ActiveJob::Base
  p "applcationjob start"
     MailSendStaffJob.perform_later
     SycCrw01CmToGrossCust.perform_later
     Log_Delete.perform_later
end
