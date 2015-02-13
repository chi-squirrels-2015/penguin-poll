class User < ActiveRecord::Base
  has_many :taken_polls, foreign_key :responder_id
  has_many :created_polls, class_name: "Poll", foreign_key :creator_id
  has_many :answers, through: :taken_polls
end
