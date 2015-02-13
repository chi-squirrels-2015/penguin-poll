get '/' do
  erb :index
end

# do we need a get?
post "users/:id" do
  @user = User.find(params[:id])
  erb :'/users/profile'
end

get "/polls" do

  erb :'polls/index'
end

get "/polls/new" do

  erb :'polls/new'
end

post "/polls" do
 #if successfully create poll
 @poll = Poll.new(params[:poll])
  if @poll.save
    redirect "/polls"
 #elsif not successful
  else
    erb :'polls/new'
  end
end


get "/polls/:id" do #shows all questions

  erb :'polls/show'
end

post "/polls/:id" do
  #if all questions answered, save poll results
  redirect '/polls'
  #else
  erb :'polls/show'
end

get "/login" do

end


get "/logout" do

end

get "/signup" do

end
