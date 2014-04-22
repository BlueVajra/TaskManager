require 'spec_helper'
require 'task_repository'
require 'project_repository'

describe TaskRepository do

  let(:repo) {TaskRepository.instance }
  let(:project_repo) {ProjectRepository.instance }
  let(:project_id) {project_repo.find(project_repo.add("First Project"))}
  let(:baz) { repo.find(repo.add("baz"), project_id)}

  before :each do
    DB[:tasks].delete
    DB[:projects].delete
    #@p_id = project_repo.add("First Project")

    repo.add("foo", project_id)
    repo.add("bar", project_id)
  end

  it "adds and retrieves tasks" do
    expect(repo.tasks[0][:task]).to eq "foo"
  end

  it "deletes tasks" do
    repo.delete(baz[:id])
    expect(repo.tasks).to_not include(baz)
  end

  it "completes and undeletes tasks" do

    repo.complete(baz[:id])
    actual = repo.completed?(baz[:id])
    expect(actual).to eq true

    repo.complete(baz[:id])
    actual = repo.completed?(baz[:id])
    expect(actual).to eq false
  end


end