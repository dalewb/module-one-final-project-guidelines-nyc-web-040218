class AddNumOfSharesToTransactions < ActiveRecord::Migration[4.2]

  def change
    add_column :transactions, :num_of_shares, :integer
  end

end
