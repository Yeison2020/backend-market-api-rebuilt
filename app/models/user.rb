class User < ApplicationRecord
    # depedent: :nullify allows the buyer to keep the id of Its current purchases 
    # depedent: :destroy allows the user to delete all the dependacies (items for sales)
    has_many :purchased_items, class_name: "Item", foreign_key: 'buyer_id', depedent: :nullify
    has_many :sold_items, class_name: "Item", foreign_key: 'seller_id', depedent: :destroy

    validates :username, presence: true, uniqueness: true 
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true, uniqueness: true
end
