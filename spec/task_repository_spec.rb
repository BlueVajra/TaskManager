require 'spec_helper'
require 'task_repository'

describe TaskRepository do

  let(:repo) {TaskRepository.instance }
  let(:baz) { repo.find(repo.add("baz"))}

  before :each do
    DB[:tasks].delete

    repo.add("foo")
    repo.add("bar")
  end

  it "adds and retrieves tasks" do
    expect(repo.tasks[0][:task]).to eq "foo"
  end

  it "deletes tasks" do
    repo.delete(baz)
    expect(repo.tasks).to not_contain(baz)
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