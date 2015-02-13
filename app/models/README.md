Add your ActiveRecord models here.

You can create them by being in the application root directory and running:

`rake generate:model NAME=User`

models

users: id, name, email, password_hash
polls: id, creator_id
response: responder _id, answer, choice_id, question_id,
questions: text open_ended? boolean
choices: question_id, content
join table polls questions: poll_id, question_id

