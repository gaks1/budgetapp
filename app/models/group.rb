class Group < ApplicationRecord
  has_one_attached :icon
  belongs_to :user
  has_many :entity_groups, dependent: :destroy
  has_many :entities, through: :entity_groups

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :icon, presence: true
end
