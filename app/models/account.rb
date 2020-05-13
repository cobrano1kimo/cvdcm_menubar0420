class Account < ApplicationRecord

  has_one :user_group
  #has_many :customer
  belongs_to :customer, foreign_key: "cust_id"

end
