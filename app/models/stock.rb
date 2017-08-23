class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
  	where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name

    new_stock = create(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  def price
    price = StockQuote::Stock.quote(ticker).close
    if price.blank?
      price = StockQuote::Stock.quote(ticker).open
    end
  end

  def display_price
	  return "$#{price}" if price
	  'Unavailable'
  end
end
