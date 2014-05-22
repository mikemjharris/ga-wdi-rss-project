class User < ActiveRecord::Base
acts_as_marker

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:twitter, :google_oauth2, :facebook]

attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :first_name, :last_name, :bio, :profile_picture_image, :profile_image

mount_uploader :profile_picture_image, ProfilePictureImageUploader



  #   def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #   if user
  #     return user
  #   else
  #     registered_user = User.where(:email => auth.info.nickname.downcase + "@twitter.com").first
  #     if registered_user
  #       return registered_user

  #     else
        
  #       user = User.create(
  #                           provider:auth.provider,
  #                           uid:auth.uid,
  #                           email:auth.info.nickname.downcase + "@twitter.com",
  #                           profile_image: auth.info.image,
  #                           first_name: auth.info.name.split[0],
  #                         )
  #     end


  #   end
  # end


  # def self.from_omniauth(auth)
  #   if user = User.find_by_email(auth.info.email)
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user
  #   else
  #     where(auth.slice(:provider, :uid)).first_or_create do |user|
  #       user.provider = auth.provider
  #       user.uid = auth.uid
  #       user.email = auth.info.email
  #       user.password = Devise.friendly_token[0,20]
  #     end
  #   end
    
  # end

  # def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  #     user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #     if user
  #       return user
  #     else
  #       registered_user = User.where(:email => auth.info.email).first
  #       if registered_user
  #         return registered_user
  #       else
  #         user = User.create(name:auth.extra.raw_info.name,
  #                             provider:auth.provider,
  #                             uid:auth.uid,
  #                             email:auth.info.email,
  #                             :profile_image => auth.info.image,
  #                             password:Devise.friendly_token[0,20],
  #                           )
  #       end   
  #     end
  #   end


  
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
      var title = document.createElement('h2');
      var title_text = document.createTextNode('Rss feeds on this page - add to Yakety!');
      title.appendChild(title_text);
      node.appendChild(title);

      for (var i = 0; i < myElements.length; i++) {
        if (myElements[i].href.indexOf('.xml') > -1) {
            var list = document.createElement('li');

            var listitem =  document.createElement('span');
            var listitem_text = document.createTextNode(myElements[i].text + ': ' );
            listitem.appendChild(listitem_text);
            listitem.setAttribute('style','color: white; margin-left: 50px; width: 200px; display: inline-block; overflow:hidden');        
            list.appendChild(listitem);

            var itemurl = document.createElement('a');
            var itemurl_text = document.createTextNode(myElements[i].href);
            itemurl.appendChild(itemurl_text);
            itemurl.href= myElements[i].href;
            itemurl.setAttribute('style','color: white; margin-left: 50px; width: 200px; display: inline-block; overflow:hidden');        
            list.appendChild(itemurl);
            
            var postit = document.createElement('a');
            var postit_text = document.createTextNode('Add to Yakety');
            postit.appendChild(postit_text);
            postit.href = 'http://localhost:3000/feeds/update/addexternal?url=' + myElements[i].href;
            postit.setAttribute('style','color: white; margin-right: 100px; font-weight: bold; display: inline-block; margin-left: 100px');
            list.appendChild(postit);  
          
            node.appendChild(list);
          };
        }; 
        node.setAttribute('style','position: fixed; top: 10px; background-color: #ca2024; z-index: 100000000000000; color: white; list-style: none; height: 500px; overflow: scroll; border: 10px solid white');
        document.getElementsByTagName('body')[0].appendChild(node);
      }());"
  

  def self.from_omniauth(auth)
    twitter_email = if auth.info.nickname then auth.info.nickname.downcase + "@twitter.com" end
     
    if user = User.find_by_email(auth.info.email) || user = User.find_by_email(twitter_email) 
      user.provider = auth.provider
      user.uid = auth.uid
      # user.profile_image = auth.info.image
      user
    else
      if auth.provider == "twitter"
        user = User.create({
              :provider => auth.provider,
              :uid => auth.uid,
              :email => auth.info.nickname.downcase + "@twitter.com",
              :first_name =>  auth.info.name.split(" ")[0],
              :last_name =>  auth.info.name.split(" ")[1],
              :bio => auth.info.description,
              :profile_image => auth.info.image,
              :password => Devise.friendly_token[0,20]
          })
          
      else
        
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.profile_image = auth.info.image
            user.password = Devise.friendly_token[0,20]
        end
      end 
    end
  end
end
