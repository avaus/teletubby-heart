class AddDefaultNameToClients < ActiveRecord::Migration
  def up
    change_column(:clients, :name, :string, default: "unnamed")
  end

  def down
    change_column(:clients, :name, :string)
  end
end
