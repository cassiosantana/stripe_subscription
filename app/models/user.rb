class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :subscription, dependent: :destroy
  has_one :customer, dependent: :destroy
end
