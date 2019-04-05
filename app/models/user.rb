class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true 
    validates :password, length: {minimum: 6, allow_nill: true}
    validates :password_digest, :session_token, presence: true 
    

     attr_reader :password 
     after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = Bcrypt::Password.create(password)
    #just encrypting the user's password right?
  end

  def is_password?(password)
    Bcrypt::Password.new(self.password_digest).is_password?(password)
    #is (password) the 'password' a user might type in upon logging in?
    #are we just comparing that password typed in with the digested password 
    #we stored in our db? 
  end

  def find_user_by_credentials(email, password)
    current_user = User.find_by(email: email)
     if current_user.is_password?(password) && current_user
        return current_user
     end 
     nil 
  end

  def ensure_session_token 
    self.session_token ||= SecureRandom::urlsafe_base64
    #is the = side just a set technique for creating a session token? 
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token  
       #creates a new session token for the user
       #saves that new user object (with a new session token)
       #returns the session token (self.sessiontoken), that way 
       #you dont return the entire user object, just their token
  end




end
