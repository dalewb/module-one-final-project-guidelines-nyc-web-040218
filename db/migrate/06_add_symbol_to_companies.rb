class AddSymbolToCompanies < ActiveRecord::Migration[4.2]

  def change
    add_column :companies, :symbol, :string
  end

end
