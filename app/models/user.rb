class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :groups
  has_many :entities

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }

  def admin?
    role == 'admin'
  end
end
