class FinderController < ApplicationController

  def index
    @finder     = ''
    @categories = Category.all
    @products   = Product.all
    @sizes      = Size.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @categories }
      format.json { render :json => @categories }
    end


  end


  def show

    @categories = Category.find(params[:id])
    @products   = @categories.products.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
      format.json { render :json => @products }
    end


  end

  def products

    @categories = Category.find(params[:id])
    @products   = @categories.products.all

    respond_to do |format|
      format.xml { render :xml => @products }
      format.json { render :json => @products }
    end

  end


  def sizes

    @product = Product.find(params[:id])
    @sizes   = @product.sizes.all


    respond_to do |format|
      format.xml { render :xml => @sizes }
      format.json { render :json => @sizes }
    end

  end

  def search

    @search = Price.where(['product_id=? AND size_id=?', params[:prod_id], params[:si_id]]).all

    @price = Price.find(:joins => "LEFT JOIN (SELECT user_id, sum(vote_count) as vote_sum FROM posts GROUP BY
user_id) p ON p.user_id = users.id",
    :select => "Users.*, vote_sum",
    :order => "vote_sum DESC").all

    #@search = Price.where(:product_id => params[:prod_id], :size_id =>  params[:si_id]).all    

    respond_to do |format|
      format.html
      format.xml { render :xml => @search }
      format.json { render :json => @search }
    end

  end

end
