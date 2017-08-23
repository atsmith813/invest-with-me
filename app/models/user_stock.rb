class UserStock < ApplicationRecord
	belongs_to :user
	belongs_to :stock

	def stock_return
		return (((stock.price - start_price) / start_price) * 100.0).round(2)
	end

	def display_stock_return
		return "#{'%.2f' % stock_return}%"
	end
end
