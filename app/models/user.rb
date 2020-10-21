class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 7}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.delete(" ").downcase)
    if user && user.authenticate(password)
      return user
    else return nil
    end
  end
end