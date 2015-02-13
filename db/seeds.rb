john = User.create(name: "Mark Penguin", email: "ilovepenguins@gmail.com", password_hash: "abc123")

retail_survey = Poll.create(name: "Retail Survey", creator: john)

Question.create(text: "Stores are conveniently located.", poll: retail_survey)
Question.create(text: "Store hours are convenient for my shopping needs.", poll: retail_survey)
Question.create(text: "Store atmosphere and decor are appealing.", poll: retail_survey)
Question.create(text: "A good selection of products was present.", poll: retail_survey)
Question.create(text: "(Store) has the lowest prices in the area.", poll: retail_survey)
Question.create(text: "Merchandise sold is of the highest quality.", poll: retail_survey)
Question.create(text: "The merchandise sold is a good value for the money.", poll: retail_survey)
Question.create(text: "Merchandise displays are attractive.", poll: retail_survey)
Question.create(text: "Advertised merchandise was in stock.", poll: retail_survey)
Question.create(text: "Overall, I am very satisfied with the store.", poll: retail_survey)
Question.create(text: "I am very satisfied with the price I paid for what I bought.", poll: retail_survey)
Question.create(text: "I am very satisfied with the merchandise I bought.", poll: retail_survey)

Question.all.each do |question|
  Choice.create(content: "Strongly Agree", question: question)
  Choice.create(content: "Agree", question: question)
  Choice.create(content: "Neutral", question: question)
  Choice.create(content: "Disagree", question: question)
  Choice.create(content: "Strongly Disagree", question: question)
end


