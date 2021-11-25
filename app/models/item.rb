class Item < ApplicationRecord
    belongs_to :seller, class_name: 'User', foreing_key: 'seller_id'
    belongs_to :buyer, class_name: 'User', foreing_key: 'buyer_id', optional: true

    has_many :category_items
    has_many :categories, through: :category_items

    # Validations models

    validates :name, :desc, presence: :true
    validates :price, presence: true, format: format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Must be dollar amount" }, numericality: { greater_than: 0, less_than: 4000  }




end
