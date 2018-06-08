class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
      if user.admin?
        can :manage, User
        can :manage, Question
        can :manage, Answer
      else
        can :show, User , id: user.id
        can [:edit, :new, :create, :destroy, :update], Question, user_id: user.id
        can [:show, :index], Question
        can [:edit, :new, :create, :destroy, :update], Answer, user_id: user.id
      end    
  end
end
