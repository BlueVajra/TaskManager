require 'sinatra/base'
require 'sequel'

class App < Sinatra::Application
  enable :sessions


  get '/' do
    tasks = Task.filter(:project_id => current_project).all
    current_project
    erb :index, locals: {
      tasks: tasks,
      projects: Project.all
    }
  end

  post '/task/new' do
    Task.create(:project_id => current_project, :task => params[:add_item])
    redirect '/'
  end

  delete '/delete/:id' do
    Task[params[:id]].delete
    redirect '/'
  end

  put '/complete/:id' do
    completed?(params[:id]) ? Task[id: params[:id]].update(completed: false) : Task[id: params[:id]].update(completed: true)
    redirect '/'
  end

  post '/project/new' do
    projects_repo.add(params[:add_project])
    redirect '/'
  end

  get '/project/:id/current' do
    make_current(params[:id])
    redirect '/'
  end

  helpers do
    def current_project
      if projects_repo.first.nil?
        projects_repo.add("Default Project")
        session[:current_project] = projects_repo.first[:project_id]
      else
        session[:current_project] ||= projects_repo.first[:project_id]
      end
    end

    def current_project_name
      projects_repo.get_name(current_project)
    end

    def completed?(id)
      Task[id: id][:completed]
    end
  end
  private
  def make_current(project_id)
    session[:current_project] = project_id
  end

  def tasks_repo
    TaskRepository.instance
  end

  def projects_repo
    ProjectRepository.instance
  end


end