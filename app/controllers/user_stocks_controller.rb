class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  # GET /user_stocks
  # GET /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1
  # GET /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks
  # POST /user_stocks.json
  def create
    if params[:stock_id].present?
      @user_stock = UserStock.create(stock_id: params[:stock_id], user: current_user, start_date: params[:start_date], start_price: params[:start_price])
    else
      stock = Stock.find_by_ticker(params[:stock_ticker])
      if stock
        @user_stock = UserStock.create(stock_id: stock, user: current_user, start_date: params[:start_date], start_price: params[:start_price])
      else
        stock = Stock.new_from_lookup(params[:stock_ticker])
          if stock.save
            @user_stock = UserStock.create(user: current_user, stock_id: stock, start_date: params[:start_date], start_price: params[:start_price])
          else
            @user_stock = nil
            flash[:error] = "Stock is not available."
          end
      end
    end

    @user_stock.update_attributes(start_date: params[:start_date], start_price: params[:start_price])

    if @user_stock.save
      flash[:success] = "#{@user_stock.stock.name} - #{@user_stock.stock.ticker} was successfully added."
      redirect_to my_portfolio_path
    end
  end

  # PATCH/PUT /user_stocks/1
  # PATCH/PUT /user_stocks/1.json
  def update
    if @user_stock.update(user_stock_params)
      flash[:success] = "Stock was successfully updated."
      redirect_to @user_stock
    end
  end

  # DELETE /user_stocks/1
  # DELETE /user_stocks/1.json
  def destroy
    @user_stock.destroy
    if @user_stock.destroy
      flash[:success] = "#{@user_stock.stock.name} - #{@user_stock.stock.ticker} was deleted."
      redirect_to my_portfolio_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = current_user.user_stocks.where(stock_id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id, :start_date, :start_price)
    end
end
