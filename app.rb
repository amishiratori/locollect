require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/map.rb'
require 'sinatra/base'
require 'faraday'
require 'json'
require 'rest-client'
require 'net/http'


get '/' do
  erb :getstarted
end

get '/home' do
  @maps = Map.all.order('id desc')
  @stores = Store.all
  @stations = Station.all
  erb :index
end
 
post '/search' do
  search = params[:search]
  @maps = Map.where("map_name like ? or name like ? ", "%" + search + "%" , "%" + search + "%")
  @stores = Store.all
  @stations = Station.all
  erb :index
end

get '/new' do
  @stations = Station.all
  erb :new
end

post '/new' do
  stores_id = []
  
  if params[:stores]
    params[:stores].each do |store| 
      stores_id << Store.create({
        name: store[1]["name"],
        address: store[1]["address"]
      }).id
    end
  end
  
  map_id = Map.create({
    name: params[:name],
    map_name: params[:map_name],
    station_id: params[:station]
  }).id
  if stores_id
    stores_id.each do |store_id|
      Map.find(map_id).stores << Store.find(store_id)
    end
  end
   
  redirect '/home'
end


post '/shops' do
  uri = URI('http://api.gnavi.co.jp/RestSearchAPI/20150630/')
  uri.query = URI.encode_www_form({
    keyid: ENV['GNAVI_KEY'],
    format: 'json',
    freeword: params[:search_word],
    hit_per_page: 30 
  });
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)
  @response_stores =  returned_json["rest"]
  @stations = Station.all
  @budget = params[:budget]
  
  erb :new
end


post '/good/:id' do
    @maps = Map.find(params[:id])
    good=""
    good = @maps.good
    @maps.update({
        good: good + 1
    })
    redirect '/home'
end

post '/more/:id' do
  @maps = Map.all
  @map = Map.find(params[:id])
  @stores = Store.all
  @stations = Station.all
  erb :more
end

# 管理ページ
get '/admin' do
  @stores = Store.all
  @maps = Map.all
  @stations = Station.all
  erb :admin
end

# map追加
post '/admin/new/map' do
  map_id = Map.create({
    name: params[:name],
    map_name: params[:map_name],
    station_id: params[:station]
  }).id
  if params[:stores]
    params[:stores].each do |store_id|
      Map.find(map_id).stores << Store.find(store_id)
    end
  end
  redirect '/admin'
end

# store追加
post '/admin/new/store' do
  Store.create({
    name: params[:name],
    address: params[:address]
  })
  redirect '/admin'
end

# map削除
post '/admin/delete/map/:id' do
  Map.find(params[:id]).delete
  
  redirect '/admin'
end

get '/admin/delete/all/store' do
  Store.all.each do |store|
    store.delete
  end
   redirect '/admin'
end

get '/admin/delete/all/map' do
  Map.all.each do |map|
    map.delete
  end
  
  redirect '/admin'
end

# store削除
post '/admin/delete/store/:id' do
  Store.find(params[:id]).delete
  
  redirect '/admin'
end

# store削除
post '/admin/delete/station/:id' do
  Station.find(params[:id]).delete
  
  redirect '/admin'
end


# encoding: utf-8

post '/admin/json' do

  uri = URI('http://api.gnavi.co.jp/RestSearchAPI/20150630/')
  uri.query = URI.encode_www_form({
    keyid: '52c3de43f5d8008176abf9c3fc643f3c',
    format: 'json',
    freeword: params[:search_word].encode("UTF-8"),
    hit_per_page: 30 
  });
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)
  @response_stores =  returned_json["rest"]
  @stores = Store.all
  @maps = Map.all
  @stations = Station.all
  erb :admin
  
  redirect '/admin'
  
end

