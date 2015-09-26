require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true
  property :password_digest, Text
  property :name, String
  property :user_name, String, unique: true

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && password_correct(user, password)
      user
    else
      nil
    end
  end

  private

  def self.password_correct(user, password)
    BCrypt::Password.new(user.password_digest) == password
  end

end