class Log_Delete < ActiveJob::Base
  queue_as :low_priority
  def perform
           scheduler = Rufus::Scheduler.new
        scheduler.cron '30 23 * * 0' do |x|
          File.exist?("#{Rails.root}/log/development.log")
            File.delete("#{Rails.root}/log/development.log")
         end
    end
end
