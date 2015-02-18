get '/' do

  erb :index
end

#users profile, all taken, all get
get "/users/:id" do
  @user = User.find(params[:id])

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
  @poll = Poll.create(creator_id: session[:user_id], name: params[:pollname])

  redirect "/polls/#{@poll.id}/questions/new"
end



get "/polls/:id/questions/new" do
  @poll = Poll.find(params[:id])
  @question_count = @poll.questions.count

  erb :'questions/new'
end

post "/polls/:id/questions" do
  @poll = Poll.find(params[:id])
  @question = Question.create(text: params[:question], poll_id: @poll.id)
  @question_count = @poll.questions.count
  params[:response].each do |response|
    Choice.create(question_id: @question.id, content: response)
  end

  content_type :json
  return { :questioncount => @question_count}.to_json
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


