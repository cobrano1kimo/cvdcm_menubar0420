class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # ActiveRecord::Base.lock_optimistically = false
  def rocTime(date)
  (date.to_i -200000).to_s
  end
end
