# This updates the prices of each Stock saved in the database
namespace :update_price do
	task stocks: [:environment] do
		Stock.all.each do |stock|
			stock_open = StockQuote::Stock.quote(stock.ticker).open
			stock_close = StockQuote::Stock.quote(stock.ticker).close
			if !stock_close == nil
				stock.update(last_price: stock_close)
			else
				stock.update(last_price: stock_open)
			end
			p "#{stock.name} was updated."
		end
	end	
end	