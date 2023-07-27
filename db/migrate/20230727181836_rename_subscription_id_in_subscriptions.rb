class RenameSubscriptionIdInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    rename_column :subscriptions, :subscription_id, :stripe_id
  end
end
