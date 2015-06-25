class Contact < ActiveRecord::Base
  belongs_to :user

  phony_normalize :phone, :default_country_code => 'US'

  validates :name, presence: true
  validates :email, presence: true
  validates_plausible_phone :phone, presence: true

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/,
    message: "Email is not valid." }

  default_scope {order('name ASC')}
end
