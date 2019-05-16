class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # ActiveRecord::Base.lock_optimistically = false
end
