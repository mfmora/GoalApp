# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  private     :string
#

class Goal < ApplicationRecord
  validates :title, :description, :private, :user, presence: true

  belongs_to :user
end
