class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.new(name: params[:figure][:name])
    figure.title_ids = params[:figure][:title_ids]
    figure.landmark_ids = params[:figure][:landmark_ids]
    figure.landmarks.build(params[:landmark]) unless params[:landmark].nil?
    figure.titles.build(params[:title]) unless params[:title].nil?
    figure.save
    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    figure = Figure.find(params[:id])
    Figure.update(params[:id], params[:figure])
    figure.landmarks.build(params[:landmark]) unless params[:landmark].nil?
    figure.title.build(params[:title]) unless params[:title].nil?
    redirect "/figures/#{figure.id}"
  end
end
