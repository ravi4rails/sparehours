class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  scope :professionals, -> { where(account_type: 'Professional') }
  scope :clients, -> { where(account_type: 'Client') }
  scope :both, -> { where(account_type: 'Professional and Client') }

  geocoded_by :address
  after_validation :geocode

  has_many :user_skills
  has_many :skills, through: :user_skills

  def name
    "#{self.first_name} #{self.last_name}".strip.capitalize
  end

end
