class CreateCompanies < ActiveRecord::Migration[4.2]

  def change
    create_table :companies do |t|
      t.string :name
      t.string :open_price
      t.string :close_price
    end
end
end
