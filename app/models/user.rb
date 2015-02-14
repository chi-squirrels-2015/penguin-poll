class User < ActiveRecord::Base
  has_many :poll_submissions, foreign_key: :responder_id
  has_many :created_polls, class_name: "Poll", foreign_key: :creator_id
  has_many :answers, through: :poll_submissions
    validates :name, :length => { :minimum => 1, :message => "must be at least 3 characters!" }
  validates :password, :length => { :minimum => 6 }
  validates :email, :uniqueness => true, :format => /.+@.+\..+/

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
   user = User.find_by_email(email)
    return user if user && (user.password == password)
  end
end
