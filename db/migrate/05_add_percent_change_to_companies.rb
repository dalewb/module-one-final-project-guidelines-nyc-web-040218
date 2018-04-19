class AddPercentChangeToCompanies < ActiveRecord::Migration[4.2]

  def change
    add_column :companies, :percent_change, :string
  end

end
