class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    authorize(@user)
    erb :'users/show'
  end 

  get '/users/:slug/edit' do 
    @user = User.find_by_slug(params[:slug])
    authorize(@user)
    erb :'users/edit'
  end 

  post '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    authorize(@user)
    @user.update(username: params[:username], email: params[:email], password: params[:password])
    erb :'users/show'
  end 
    
end