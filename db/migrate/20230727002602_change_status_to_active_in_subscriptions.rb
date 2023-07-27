class ChangeStatusToActiveInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :status, :string
    add_column :subscriptions, :active, :boolean, default: false
  end
end
