get '/' do
  erb :index
end

#users profile, all taken, all get
get "/users/:id" do

  p params[:id]
  @user = User.find(params[:id])
  p @user
  erb :'/users/profile'
end

get "/polls" do
  ensure_login
  @polls = Poll.all
  erb :'polls/index'
end

get "/polls/new" do
  ensure_login
  erb :'polls/new'
end

post "/polls" do
  #if successfully create poll
  user = current_user
  puts params
  puts params[:question]
  puts params[:questions]
  puts params[:questions][:choices]

  @poll = Poll.new(creator_id: user.id, name: params[:name])
  questions = params[:question][:text]
  # @question = Question.create(text: params[:question][:text][0], poll: @poll)
  choices = params[:question][:questions][:choices]
  questions.each_with_index do |question, index|
    db_question = Question.create(text: question, poll: @poll)
    for i in 0..4 do
      Choice.create(question: db_question, content: choices[i])
    end
    choices.shift(5)
  end
  # choices.each do |choice|
  #   Choice.create(question: @question, content: choice)
  # end
  if @poll.save
    redirect "/polls"
  #elsif not successful
  else
    erb :'polls/new'
  end
end



get "/polls/:id" do #shows one poll
  @poll = Poll.find(params[:id])
  #session to get responder id
  erb :'polls/show'
end

post "/polls/:id" do
  #if all questions answered, save poll results
  p params
  @poll = Poll.find(params[:id])
  @poll_submitted = PollSubmission.create(poll_id: params[:id], responder_id: session[:user_id])
  @poll.questions.each do |poll_question|
    Answer.create(choice_id: params[:"#{poll_question.id}"], poll_submission_id: @poll_submitted.id)   #need to find a way to store the choice made on radio button, choice_id
  end

  redirect '/polls'
  #else
  erb :'polls/show'
end

get '/login' do
  erb :'users/login'
end

post '/login' do
  #if password matches database, go to profile
  @email = params[:user][:email]
  @user = User.authenticate(@email, params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :'users/login'
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/'
end

get "/signup" do
  erb :'users/new'
end

post "/signup" do
  if User.find_by(email: params[:user][:email])
    erb :'users/new'
  else
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end
end

def ensure_login
  if session[:user_id].nil?
    redirect "/login"
  end
end


