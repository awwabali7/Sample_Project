class User < ActiveRecord::Base
  has_many :questions,dependent: :destroy
  has_many :answers,dependent: :destroy
  devise   :database_authenticatable,:registerable,
           :recoverable,:rememberable,:trackable,:validatable,:confirmable
  before_save { self.email==email.downcase }
  default_scope -> { order(created_at: :desc) }
  enum role: { user:1 , admin:0 }

  def admin?
    role == "admin"
  end

  
end
