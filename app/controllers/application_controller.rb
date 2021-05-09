require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do # 6. 'displays all the recipes'
    @recipes = Recipe.all

    erb :index
  end

  get '/recipes/new' do # 3. 'a controller that will render a form to create a new recipe'
    erb :new
  end

  post '/recipes/new' do # 3. 'this controller action will create and save a new recipe to the database'
    if Recipe.create(params).save
      recipe = Recipe.create(params)
      recipe.save
      session[:id] = recipe[:id]
      redirect "/recipes/#{recipe[:id]}"
    else
      redirect '/recipes/new'
    end
  end

  get '/recipes/:id' do #  #. 'this controller will show the details of an individual recipe from the params'
    @recipe = Recipe.all.find(params[:id])

    erb :show
  end

  get '/recipes/:id/edit' do # #. 'this controller allows the user to edit a particular recipe'
    if !!Recipe.all.find(params[:id])
    @recipe = Recipe.all.find(params[:id])
    erb :edit
    else
      puts "Recipe not found"
    end
  end

  patch '/recipes/:id/edit' do
    recipe = Recipe.all.find(params[:id])
    recipe.update(params)
    recipe.save
    redirect "/recipes/#{recipe[:id]}"
  end

end
