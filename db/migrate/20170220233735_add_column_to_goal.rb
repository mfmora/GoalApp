class AddColumnToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :private, :string
  end
end
