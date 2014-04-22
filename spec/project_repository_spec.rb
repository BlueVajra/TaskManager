require 'spec_helper'

describe ProjectRepository do

  let(:repo) {ProjectRepository.instance}

  before :each do
    DB[:projects].delete

    repo.add("foo")
    @project_id = repo.add("bar")
  end

  it "creates a project" do
    expect(repo.all[0][:project_name]).to eq "foo"
  end

  it "gets a project name" do
    expect(repo.get_name(@project_id)).to eq "bar"
  end
end