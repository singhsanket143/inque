class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable,:recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
has_many :questions,dependent: :destroy
has_many :answers,dependent: :destroy
has_many :comments,dependent: :destroy
enum role: {guest: 0, member: 1,moderator: 2,admin: 3}
  validates :phoneno, length: { is: 10 }
  validates :name, presence: true
def feed
  	Question.includes(:user).order(created_at: :desc)
end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
           user.email = auth.info.email
           user.password = Devise.friendly_token[0,20]
            user.name=auth.info.first_name

    end
  end
end
