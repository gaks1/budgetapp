class Entity < ApplicationRecord
  belongs_to :author
  has_many :entity_groups
  has_many :groups , through: :entity_groups

  validates :name, presence: true, length: { minimum:3, maximum: 255 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
