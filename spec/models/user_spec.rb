# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  before(:context) do
    @user = User.create(username: 'username', password: 'secret')
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:password)
         .is_at_least(6)
         }
  end

  describe 'class methods' do
    it "should return the right user for find by credentials" do
      expect(User.find_by_credentials("username", "secret")).to eq(@user)
    end
  end
end
