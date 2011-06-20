class PricesController < ApplicationController

  def index

    @title  = 'Priser'

    @prices = Price.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @prices }
    end
  end

  def show
    @price = Price.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @price }
    end

  end

  def new
    @retailer = Retailer.find(params[:id])
    @products = Product.all
    @sum = @products.count - @retailer.price.count
    @retailer.price.count
    @products.count




    @products.each do |products|
      if @retailer.price.find_by_product_id(products.id)
        products.sizes.each do |size|
          if @retailer.price.find_by_size_id(size.id)
          else
            @retailer.price.build(:product_id => products.id, :size_id => size.id)
          end
        end
      else
        products.sizes.each do |size|
          @retailer.price.build(:product_id => products.id, :size_id => size.id)
        end
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @price }
    end
  end

  def edit
    @price     = Price.find(params[:id])
    @products  = Product
    @retailers = Retailer
    @sizes     = ProductSize
  end


  def create
    params[:fields].each do |i, values|
      # where i is the i-th set
      # and values are the user inputs

      u = Price.create(values)
    end


    if @price.save
      flash[:notice] = "Successfully created project."
      redirect_to price_path
    else
      render :action => 'new'
    end

  end

  def update
    @price = Price.find(params[:id])

    respond_to do |format|
      if @price.update_attributes(params[:price])
        format.html { redirect_to(@price, :notice => 'Price was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @price.errors, :status => :unprocessable_entity }
      end
    end

  end


  def destroy
    @price = Price.find(params[:id])
    @price.destroy

    respond_to do |format|
      format.html { redirect_to(prices_url) }
      format.xml { head :ok }
    end
  end

end
