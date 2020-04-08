class Invoice < ApplicationRecord

  #dependencies
  belongs_to :customer
  belongs_to :employee
  belongs_to :invoicestatus

  #delete cascading
  has_many :payments, dependent: :delete_all
  has_many :orderinvoices, dependent: :delete_all
  has_many :invoiceshipments, dependent: :delete_all

  #associative relation
  has_many :shipments, through: :invoiceshipments
  has_many :orders, through: :orderinvoices

  #field validation
  validates :invoicenum, uniqueness: true, length: { maximum: 128 }#, format: { with: /\A[a-z\d][a-z\d-]*[a-z\d-]\z/i }
  validates :invoicedate, presence: true
  validates :duedate, presence: true
  validates :customer_id, presence: true
  validates :employee_id, presence: true
  validates :invoicestatus_id, presence: true
  validates :amountdue, presence: true, numericality: { greater_than_or_equal_to: 0}

end
