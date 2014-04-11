require 'sinatra/base'

class App < Sinatra::Application

  get '/' do
    erb :index, locals: {tasks: DB[:tasks].to_a}
  end

  post '/' do
    DB[:tasks].insert(task: params[:add_item])
    redirect '/'
  end


end