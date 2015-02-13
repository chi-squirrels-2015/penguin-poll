class Question < ActiveRecord::Base
  belongs_to :poll
  has_many :choices
  has_many :answers, through: :choices
end
