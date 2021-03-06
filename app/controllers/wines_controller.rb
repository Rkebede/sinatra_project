class WinesController < ApplicationController

  get '/wines/new' do
    @countries = Country.all.order(:name)
    erb :'wines/new'
  end 

  post '/wines' do 
    country = Country.find_by(name: params[:country])
      @wine = Wine.new(
      name: sanitize(params[:name]), 
      country: country, 
      wine_type: sanitize(params[:wine_type]), 
      price: params[:price], 
      year_sealed: params[:year]
    ) 
    if @wine.save 
      current_user.wines << @wine
      redirect "users/#{current_user.slug}"
    else 
      @countries = Country.all.order(:name)
      erb :'wines/new'
    end 
      
  end 

  get '/wines/:id/edit' do
    @countries = Country.all.order(:name)
    @wine = Wine.find_by(id: params[:id])
    authorize(@wine.user)    
    erb :'wines/edit'
  end 
  
  patch '/wines/:id' do
    @wine = Wine.find_or_create_by(id: params[:id])
    country = Country.find_by(name: params[:country])
    authorize(current_user)
    if @wine && @wine.update(
      name: sanitize(params[:name]), 
      country: country, 
      wine_type: sanitize(params[:wine_type]), 
      price: params[:price], 
      year_sealed: params[:year]
    )
      redirect "users/#{current_user.slug}"
    else 
      erb :'wines/<%=@wine.id%>/edit'
    end 
  end 
  
  get '/wines/:id' do 
    @wine = Wine.find(params[:id])
    authorize(@wine.user)
    erb :'wines/show'
  end 

  delete '/wines/:id' do 
    @wine = Wine.find_by(id: params[:id])
    authorize(@wine.user)
    @wine.destroy
    redirect "users/#{current_user.slug}"
  end 
  
end