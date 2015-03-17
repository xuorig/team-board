require 'rails_helper'

RSpec.describe ManagerProject, :type => :model do
  it 'has a valid factory' do
    expect(build(:manager_projects)).to be_valid
  end

  it 'must not accept null project' do
    expect(build(:manager_projects, project: nil)).not_to be_valid
  end

  it 'must not accept null user' do
    expect(build(:manager_projects, user: nil)).not_to be_valid
  end
end
