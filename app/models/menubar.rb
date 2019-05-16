class Menubar < ApplicationRecord

  # 指定 primary key 為 menu_id
  self.primary_key = :menu_id

  # 選單編號不可空白，長度必須為6到8位字元
  validates :menu_id, presence: true, length: { in: 6..8 }

  # 選單名稱不可空白
  validates :menu_name, presence: true

  # 父選單可空白不輸入，若輸入值必須為6位字元，為選項必須為父選項編號
  validates :parent_menu_id, length: { is: 6 }, allow_blank: true

  # 方法二：
  def update_with_conflict_validation(*args)
    update_attributes(*args)
  rescue ActiveRecord::StaleObjectError
    self.lock_version = lock_version_was
    errors.add :base, "This record changed while you were editing."
    changes.except("updated_at").each do |name, values|
      errors.add name, "was #{values.first}"
    end
    false
  end

  # attr_accessor :original_updated_at
  # validate :handle_conflict, on: :update
  #
  # def original_updated_at
  #   @original_updated_at || updated_at.to_f
  # end
  # attr_writer :original_updated_at
  #
  # def handle_conflict
  #   if @conflict || updated_at.to_f > @original_updated_at.to_f
  #     @confilict = true
  #     @original_updated_at = nil
  #     errors[:base] << "This record changed while you were editing."
  #     changes.except("updated_at").each do |name, values|
  #       errors.add name, "was #{values.first}"
  #     end
  #   end
  #   false
  # end

  # 更新 lock_version 資訊
  # validates_presence_of :lock_version, on: :update
  # ActiveRecord::Base.lock_optimistically = false
  # self.locking_column = :lock_version

  # include AASM
  #
  # aasm do
  #   state :browsing, initial: true
  #   state :creating, :editing, :deleting, :searching, :printing, :printing_barcode, :submitting, :cancelling
  #
  #   event :create do
  #     transitions from: :browsing, to: :creating
  #   end
  #
  #   event :edit do
  #     transitions from: :browsing, to: :editing
  #   end
  #
  #   event :delete do
  #     transitions from: :browsing, to: :deleting
  #   end
  #
  #   event :search do
  #     transitions from: :browsing, to: :searching
  #   end
  #
  #   event :print do
  #     transitions from: :browsing, to: :printing
  #   end
  #
  #   event :print_barcode do
  #     transitions from: :browsing, to: :printing_barcode
  #   end
  #
  #   event :submit do
  #     transitions from: [:creating, :editing, :deleting, :searching, :printing, :printing_barcode], to: :submitting
  #   end
  #
  #   event :cancel do
  #     transitions from: [:creating, :editing, :deleting, :searching, :printing, :printing_barcode], to: :cancelling
  #   end
  #
  #   event :submitted do
  #     transitions from: :submitting, to: :browsing
  #   end
  #
  #   event :cancelled  do
  #     transitions from: :cancelling, to: :browsing
  #   end
  #
  # end

end
