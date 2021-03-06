class Employee < ApplicationRecord

  #dependencies
  belongs_to :department
  belongs_to :employeestatus
  belongs_to :user, optional: true

  #normalized for
  has_many :invoices

  #field validation
  validates :empfname, presence: true, format: { with: /\A[a-z ][a-z- ]*[a-z-' ]\z/i }, length: { maximum: 128 }
  validates :emplname, presence: true, format: { with: /\A[a-z ][a-z- ]*[a-z-' ]\z/i }, length: { maximum: 128 }
  validates :address, presence: true, length: { maximum: 128 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 254 }
  validates :phone, presence: true, length: { maximum: 64 }
  validates :title, presence: true, length: { maximum: 128 }
  validates :hiredate, presence: true
  validates :employeestatus_id, presence: true
  validates :user_id, uniqueness: true, allow_nil: true

  def emp_fullname
    "#{empfname} #{emplname}"
  end

end
