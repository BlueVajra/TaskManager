require 'sinatra/base'
require 'sequel'

class App < Sinatra::Application
  enable :sessions


  get '/' do
    erb :index, locals: {projects: Project.all}
  end

  post '/task/new' do

    #Task.create(:project_id => session[:current_project], :task => params[:add_item])

    # Above and Below are same:

    Project[session[:current_project]].add_task(Task.create(:task => params[:add_item]))

    # have the session be a Project Instance????
    # have a project isntance elsewhere?

    redirect '/project'
  end

  delete '/task/delete/:id' do
    Task[params[:id]].delete
    redirect '/project'
  end

  put '/task/complete/:id' do
    completed?(params[:id]) ? Task[id: params[:id]].update(completed: false) : Task[id: params[:id]].update(completed: true)
    redirect '/project'
  end

  get '/project' do
    erb :project, locals: {
      tasks: Project[session[:current_project]].tasks,
      projects: Project.all
    }
  end

  post '/project/new' do
    Project.create(:project_name => params[:add_project])
    redirect '/'
  end

  get '/project/:id/current' do
    set_current_project(params[:id])
    redirect '/project'
  end

  helpers do

    def current_project_name
      Project[session[:current_project]][:project_name]
    end

    def completed?(id)
      Task[id: id][:completed]
    end
  end

  private

  def set_current_project(project_id)
    session[:current_project] = project_id
  end

end