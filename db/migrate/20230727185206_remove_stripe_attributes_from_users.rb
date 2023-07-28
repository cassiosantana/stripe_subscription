class RemoveStripeAttributesFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :stripe_id, :string
    remove_column :users, :subscription_id, :string
    remove_column :users, :expires_at, :datetime
  end
end
