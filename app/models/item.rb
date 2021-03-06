class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_time
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :category
  belongs_to_active_hash :sending_area

  # ジャンルの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :status_id
    validates :shipping_time_id
    validates :delivery_charge_id
    validates :category_id
    validates :sending_area_id
  end

  with_options presence: true do
    validates :name, :description, :image
    validates :price, format: { with: /\d/, message: 'is invalid. Input half-width integer.' }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  end
end
