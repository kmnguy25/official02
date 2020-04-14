class Auction < ApplicationRecord

  #dependencies
  belongs_to :location, optional: true

  #normalized for
  has_many :cars

  #associative relations
  #has_many :orders, through: :order_auctions

  #nested forms
  #accepts_nested_attributes_for :order_auctions, reject_if: :all_blank, allow_destroy: :true

  #fields validation
  validates :auctionname, presence: true, length: { maximum: 128 }
  validates :address, presence: true, length: { maximum: 128 }
  # validates :location_id, presence: true

end
