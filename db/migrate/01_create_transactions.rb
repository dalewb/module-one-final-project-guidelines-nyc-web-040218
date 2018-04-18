class CreateTransactions < ActiveRecord::Migration[4.2]

  def change
    create_table :transactions do |t|
      t.integer :company_id
      t.integer :user_id
      t.boolean :buy
    end
  end
end
