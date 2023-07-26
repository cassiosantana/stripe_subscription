class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subscription_id
      t.datetime :current_period_start
      t.datetime :current_period_end

      t.timestamps
    end
  end
end
