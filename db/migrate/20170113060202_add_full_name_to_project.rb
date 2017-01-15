class AddFullNameToProject < ActiveRecord::Migration
  def change
    add_column :projects, :full_name, :string
  end
end
