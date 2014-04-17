require 'sinatra/base'

class App < Sinatra::Application

  get '/' do
    erb :index, locals: {tasks: tasks_repo.tasks}
  end

  post '/' do
    tasks_repo.add(params[:add_item])
    redirect '/'
  end

  delete '/delete/:id' do
    tasks_repo.delete(params[:id])
    redirect '/'
  end

  put '/complete/:id' do
    tasks_repo.complete(params[:id])
    redirect '/'
  end

  private

  def tasks_repo
    TaskRepository.instance
  end


end