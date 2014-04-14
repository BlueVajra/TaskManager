require 'sinatra/base'

class App < Sinatra::Application

  get '/' do
    erb :index, locals: {tasks: TASKS.tasks}
  end

  post '/' do
    TASKS.add(params[:add_item])
    redirect '/'
  end

  delete '/delete/:id' do
    TASKS.delete(params[:id])
    redirect '/'
  end


end