class User < ApplicationRecord
    has_many :groups
    has_many :entities

    validates :name, presence: true, length: { minimum:3, maximum: 255 }
end
