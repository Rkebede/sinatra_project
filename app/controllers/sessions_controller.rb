class SessionsController < ApplicationController
  
  get '/signup' do 
    erb :'sessions/signup'
  end 

  get '/login' do 
    erb :'sessions/login'
  end 

  post '/login' do 
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect :"/users/#{user.slug}"     
    else
      @err = "Invalid Credentials"
      erb :'login'
    end
  end 

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect :"/users/#{user.slug}"     
    else
      erb :'sessions/signup'
    end 
  end

  delete '/logout' do 
    session.clear
    redirect '/login'
  end 

end