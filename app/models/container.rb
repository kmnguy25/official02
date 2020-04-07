class Container < ApplicationRecord

  #dependencies
  belongs_to :company
  belongs_to :shipment

  #delete cascading
  has_many :containerorders

  #associative relation
  has_many :orders, through: :containerorders

  #field validation
  validates :containernum, presence: true, format: { with: /\A[a-z\d][a-z\d-]*[a-z\d-]\z/i }, length: { maximum: 128 }
  validates :shipment_id, presence: true
  validates :company_id, presence: true

end
