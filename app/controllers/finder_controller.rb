class FinderController < ApplicationController
  skip_before_filter :store_location

  def index
    @finder     = ''
    @categories = Category.all(:order => :name)
    @products   = Product
    @sizes      = ProductSize
    @amount     = [1..15]

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml { render :xml => @categories }
      format.json { render :json => @categories }
    end


  end


  def show

    respond_to do |format|
      format.html { render 'search' }
      format.xml { render :xml => @products }
      format.json { render :json => @products }
    end


  end

  def products

    @categories = Category.find(params[:id])
    @products   = @categories.products.all

    respond_to do |format|
      format.html
      format.xml { render :xml => @products }
      format.json { render :json => @products }
    end

  end


  def sizes

    @product = Product.find(params[:id])
    @sizes   = @product.productSize.all


    respond_to do |format|
      format.xml { render :xml => @sizes }
      format.json { render :json => @sizes }
    end

  end

  def search

    #@search = Price.where(['product_id=? AND size_id=?', params[:prod_id], params[:si_id]]).all

    #@sorted_search = @search.price()

    #

    ##@product = Product.includes(:prices => {:retailer => :profile}).select("products.*, (prices.price + profiles.shippingcost) AS sum).order(:sum)")

    #@product = Product.first.sizes.first.price.first.retailer.profile.shippingCost

    #@price = Price.find_by_sql("SELECT * FROM prices")

    #@price = Price.find_by_sql("SELECT prices.id, prices.retailer_id, (prices.price + profiles.shippingCost) as
    #totalPrice FROM prices LEFT JOIN profiles ON profiles.retailer_id = profiles.retailer_id
    #WHERE prices.product_id=1 AND prices.size_id=1 ORDER BY totalPrice")

    #@price = Price.includes(:retailer, :retailer => :profile)

    #@price = Price.joins(:retailer, :retailer => :profile).
    #    where(['product_id=? AND size_id=?', params[:prod_id], params[:si_id]]).
    #    group(:price).
    #    order(['SUM((prices.price) + profiles.shippingCost)', params[:prod_id]]).all



    #@price = Price.select(['`prices`.*, ((`prices`.price)+ `profiles`.shippingCost) AS totalPrice']).joins(:retailer, :retailer => :profile).where(['product_id=? AND size_id=?', params[:prod_id], params[:si_id]]).order(:totalPrice)


    #@price = Price.find(1, :joins => "LEFT JOIN (SELECT retailer_id, sum(shippingCost) as vote_sum FROM profiles GROUP BY
    #retailer_id) p ON p.retailer_id = retailer_id ",
    #  :select => " Prices.*, vote_sum ",
    #  :order => " vote_sum DESC ").all

    #@search = Price.where(:product_id => params[:prod_id], :size_id =>  params[:si_id]).all
    if params[:amount] == "-" || params[:amount].nil? || params[:prod_id] == "-" || params[:prod_id].nil? || params[:si_id] == "-" || params[:si_id].nil?
      respond_to do |format|
        format.js { render 'fail_search.js.erb' }
      end
    else

    if params[:limit].nil? || params[:limit] == "-" || params[:limit] == "alla"
      @count = Price.where(['product_id=? AND productSize_id=?', params[:prod_id], params[:si_id]]).count
      @limit = @count
    else
      @limit = params[:limit]
    end

    @amount  = Integer(params[:amount])

    @prices   = Price.select("`prices`.*").joins(:retailer, :retailer => :profile).
        where(['product_id=? AND productSize_id=?', params[:prod_id], params[:si_id]]).
        group(:retailer_id).order("SUM((prices.price * #{params[:amount].to_i}) + profiles.shippingCost)").limit(@limit)#.page(params[:page])

    @best = @prices.first

    @product = Product.find(params[:prod_id])

    @size    = @prices.first.productSize

      respond_to do |format|
        format.html
        format.js
        format.xml { render :xml => @prices }
        format.json { render :json => @prices }
      end

    end


  end

  def shipping_info
    @retailer = Retailer.find(params[:id])

    respond_to do |format|
      format.js {render 'finder/shippingInfo.js.erb'}
    end
  end
end