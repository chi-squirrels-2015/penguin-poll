class Answer < ActiveRecord::Base
  belongs_to :choice
  belongs_to :poll_submission
end
