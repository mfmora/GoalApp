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

FactoryGirl.define do
  factory :goal do
    title "MyString"
    description "MyText"
    user_id 1
  end
end
