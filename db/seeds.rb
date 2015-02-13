john = User.new(name: "Mark Penguin", email: "ilovepenguins@gmail.com", password_hash: abc123)

retail_survey = Poll.new(name: "Retail Survey", creator: john)

Question.new(text: "Stores are conveniently located.", poll: retail_survey)
Question.new(text: "Store hours are convenient for my shopping needs.", poll: retail_survey)
Question.new(text: "Store atmosphere and decor are appealing.", poll: retail_survey)
Question.new(text: "A good selection of products was present.", poll: retail_survey)
Question.new(text: "(Store) has the lowest prices in the area.", poll: retail_survey)
Question.new(text: "Merchandise sold is of the highest quality.", poll: retail_survey)
Question.new(text: "The merchandise sold is a good value for the money.", poll: retail_survey)
Question.new(text: "Merchandise displays are attractive.", poll: retail_survey)
Question.new(text: "Advertised merchandise was in stock.", poll: retail_survey)
Question.new(text: "Overall, I am very satisfied with the store.", poll: retail_survey)
Question.new(text: "I am very satisfied with the price I paid for what I bought.", poll: retail_survey)
Question.new(text: "I am very satisfied with the merchandise I bought.", poll: retail_survey)

Question.all.each do |question|
  Choice.new(content: "Strongly Agree", question_id: question.id)
  Choice.new(content: "Agree", question_id: question.id)
  Choice.new(content: "Neutral", question_id: question.id)
  Choice.new(content: "Disagree", question_id: question.id)
  Choice.new(content: "Strongly Disagree", question_id: question.id)
end


