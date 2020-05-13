class Customer < ApplicationRecord
  self.primary_key = 'cust_id'
  has_many :account
  # belongs_to :account, foreign_key: "won_staff"
  has_one :user_group
end
