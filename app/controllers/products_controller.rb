# encoding: utf-8

class ProductsController < ApplicationController
  before_filter :comments

  def index

    @title    = 'Produkter'

    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end

  def show
    @product = Product.find(params[:id])
    @price   = @product.prices
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
      format.json { render :json => @product }
    end

  end


  #def _search
  #  @product = Product.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html
  #  end
  #end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end


  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(products_url, :notice => 'Price was successfully created!') }
        format.xml { render :xml => @product, :status => :created, :location => 'index' }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Article was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end

  end


  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to (products_url) }
      format.xml { head :ok }
    end
  end

  def retailer_comment(user)
    if current_user
      @comment = user.comments.build(params[:comment])
      respond_to do |format|
        if @user.comment.save
          format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
          format.xml { render :xml => @comment, :status => :created, :location => @comment }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end

    else

    end

  end

  def update_products
    respond_to do |format|
      format.js { render 'updateProducts.js.erb'}
    end
  end

  private

  def comments
    if params[:id]
      if current_user
        @product = Product.find(params[:id])
        @user    = current_user
        @comment = @user.comments.new(:product_id => @product.id)
      else
        @product = Product.find(params[:id])
        @user    = User.new
        @user.comments.build(:product_id => @product.id)
      end
    end
  end

end
