class Account < ApplicationRecord
attr_accessor :acc_staff
attr_accessor :paymark
attr_accessor :mail_show_mark
attr_accessor :mail_until_closeday
attr_accessor :mail_show_mark_clsday
has_one :user_group
  #has_many :customer
belongs_to :customer, foreign_key: "cust_id"

end
