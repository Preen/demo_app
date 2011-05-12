class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_voter

  has_many :authentications
  has_many :comments

  accepts_nested_attributes_for :comments

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email']

    # Update user info fetching from social network
    case omniauth['provider']
      when 'facebook'
        # fetch extra user info from facebook
      when 'twitter'
        # fetch extra user info from twitter
    end
  end


end
