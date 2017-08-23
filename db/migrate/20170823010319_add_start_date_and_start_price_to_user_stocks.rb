class AddStartDateAndStartPriceToUserStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :user_stocks, :start_date, :datetime
    add_column :user_stocks, :start_price, :decimal
  end
end
