get '/' do
  redirect '/login'
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
  p params
  @poll = Poll.create(creator_id: session[:user_id], name: params[:pollname])
  @poll.save
# @question = Question.create( poll_id: params[@poll.id])
  if request.xhr?
    erb :"/polls/_form", locals: {poll: @poll}, layout: false
  else
    redirect "/" # HINT: what does this do? what should we do instead?
  end
end

post "/questions" do
  @poll = Poll.last
  p params
  @question = Question.create(text: params[:question], poll_id: @poll.id)
  p @poll
  p @question
  if request.xhr?
    erb :"polls/response", locals: {question: @question}, layout: false
  else
    redirect "/" # HINT: what does this do? what should we do instead?
  end
end


post "/responses" do
  @question = Question.last
  puts "There should be something below this"
  puts @question.id
  puts "there should be something above this"
  # Change the word "response" in @response to another name. It seems like ruby and/or ajax is getting confused. It should work.
  Choice.create(content: params[:response], question_id: @question.id)
  if request.xhr?
    puts "in XHR"
    puts params
    puts @question
    # puts @response
    erb :"polls/response", layout: false
  else
    redirect "/" # HINT: what does this do? what should we do instead?
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

get '/polls/:id/results' do
  @poll = Poll.find(params[:id])
  erb :'/polls/results'
end

get '/login' do
  erb :'/users/login'
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


