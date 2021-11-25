class User < ApplicationRecord
    has_many :purchased_items, class_name: 'Item', foreing_key: 'buyer_id'
    has_many :sold_items, class_name: 'Item',foreing_key: 'seller_id'


    #validations 
    validates :name, presence: true 
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true
end
