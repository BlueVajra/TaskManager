require 'spec_helper'
require 'task_repository'

describe TaskRepository do

  before :each do
    DB[:tasks].delete
  end

  it "adds and retrieves tasks" do

    repo = TaskRepository.new(DB)
    repo.add("First Item")
    repo.add("Second Item")
    repo.add("Third Item")

    expect(repo.tasks[1][:task]).to eq "Second Item"
  end

  it "deletes tasks" do
    repo = TaskRepository.new(DB)
    repo.add("First Item")
    return_id = repo.add("Second Item")
    repo.add("Third Item")

    repo.delete(return_id)

    expect(repo.tasks[1][:task]).to eq "Third Item"

  end
end