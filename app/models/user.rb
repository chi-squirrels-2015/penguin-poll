class User < ActiveRecord::Base
  has_many :poll_submissions, foreign_key: :responder_id
  has_many :created_polls, class_name: "Poll", foreign_key: :creator_id
  has_many :answers, through: :poll_submissions
end
