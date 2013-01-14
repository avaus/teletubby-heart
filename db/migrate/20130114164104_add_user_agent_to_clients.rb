class AddUserAgentToClients < ActiveRecord::Migration
  def change
    add_column :clients, :user_agent, :text
  end
end
