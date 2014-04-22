require 'sinatra/base'
require 'sequel'

class App < Sinatra::Application
  enable :sessions


  get '/' do
    #Project.new.tasks
    tasks = Task.filter(:project_id=>current_project).all
    current_project
    #tasks = @current_project.tasks
    erb :index, locals: {
      tasks: tasks,
      #tasks:  @current_project.tasks,
      projects: Project.all
    }
  end

  post '/task/new' do
    #puts "CURRENT PROJECT: #{current_project_name}"
    Task.create(:project_id => current_project, :task=>params[:add_item])
    redirect '/'
  end

  delete '/delete/:id' do
    #tasks_repo.delete(params[:id])
    Task[params[:id]].delete
    redirect '/'
  end

  put '/complete/:id' do
    #tasks_repo.complete(params[:id])
    #@db[id: id][:completed]
    completed?(params[:id]) ? Task[id: params[:id]].update(completed:false) : Task[id: params[:id]].update(completed:true)

    #Task[params[:id]].update()
    redirect '/'
  end

  post '/project/new' do
    projects_repo.add(params[:add_project])
    redirect '/'
  end

  get '/project/:id/current' do
    #@current_project = Project[params[:id]]
      make_current(params[:id])
    redirect '/'
  end

  helpers do
    def current_project
      if projects_repo.first.nil?
        projects_repo.add("Default Project")
        #@current_project = Project[:project_name => "Default Project"][:project_id].values
        session[:current_project] = projects_repo.first[:project_id]
      else
        #@current_project ||= Project.first
        session[:current_project] ||= projects_repo.first[:project_id]
      end
      #if Project.first.nil?
      #  Project.create(:project_name => "Default Project")
      #end
      #  @current_project ||= Project.first



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