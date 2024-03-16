class Item < ApplicationRecord
  belongs_to :user

  validates :buyer, presence: true
  validates :item_name, presence: true
  validates :zipcode, presence: true
  validates :address1, presence: true
  validates :address2, presence: true
  validates :address3, presence: true
  validates :banchi, presence: true
  validates :tel, presence: true

end
