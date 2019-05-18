class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  validates :address, uniqueness: true
  validates :address, format: { with: /\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\Z/,
    message: "only allows a valid IPV4" }
end