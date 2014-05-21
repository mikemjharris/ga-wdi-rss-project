class User < ActiveRecord::Base

    acts_as_marker

    devise :omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:twitter, :google_oauth2, :facebook]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :first_name, :last_name, :profile_image
  # attr_accessible :title, :body

    def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.nickname.downcase + "@twitter.com").first
      if registered_user
        return registered_user

      else
        
        user = User.create(
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.nickname.downcase + "@twitter.com",
                            profile_image: auth.info.image,
                          )
      end


    end
  end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
    
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      if user
        return user
      else
        registered_user = User.where(:email => auth.info.email).first
        if registered_user
          return registered_user
        else
          user = User.create(name:auth.extra.raw_info.name,
                              provider:auth.provider,
                              uid:auth.uid,
                              email:auth.info.email,
                              :profile_image => auth.info.image,
                              password:Devise.friendly_token[0,20],
                            )
        end   
      end
    end


  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end


  has_many :subscriptions
  has_many :feeds, :through => :subscriptions
  has_many :categories
  has_many :articles, :through => :feeds

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  $bookmarklet = "
  javascript: (
  function () { 
      var myElements = document.getElementsByTagName('a');
      var node=document.createElement('ul');
      var title = document.createTextNode('Rss feeds on this page');
      node.appendChild(title);

      for (var i = 0; i < myElements.length; i++) {
        if (myElements[i].href.indexOf('.xml') > -1) {
            var listitem = document.createElement('li'); 
            var itemtext = document.createTextNode(myElements[i].text + myElements[i].href );
            listitem.appendChild(itemtext);
            node.appendChild(listitem);
          };

        }; 
        node.setAttribute('style','position: fixed; top: 10px; background-color: yellow; z-index: 100000000000000');
        document.getElementsByTagName('body')[0].appendChild(node);
        

  }()); "
end
