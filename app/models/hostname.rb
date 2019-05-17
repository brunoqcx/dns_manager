class Hostname < ApplicationRecord
  has_and_belongs_to_many :dns_records

  validates :name, uniqueness: true
  validates :name, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/,
    message: "only allows a valid Hostname" } 
end
