class PollSubmission < ActiveRecord::Base
  belongs_to :responder, class_name: "User"
  belongs_to :poll
  has_many :answers
end
