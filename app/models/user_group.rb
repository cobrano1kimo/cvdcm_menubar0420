class UserGroup < ApplicationRecord
    belongs_to :customer,optional: true
    belongs_to :account,optional: true
end
