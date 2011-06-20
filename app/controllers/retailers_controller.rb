# encoding: utf-8
class RetailersController < ApplicationController
  before_filter :admin_user, :only => [:destroy, :edit, :create, :new, :update]
  before_filter :comments

  def search

    @retailers = Retailer.what(params[:choice])

    respond_to do |format|
      format.js
    end
  end


  def index

    @title     = 'Linsbutiker'

    @retailers = Retailer.all

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml { render :xml => @retailers }
    end
  end

  def show
    @retailer           = Retailer.find(params[:id])

    @voted_for          = @retailer.votes_for
    @voted_against      = @retailer.votes_against
    @sum                = @voted_for + @voted_against

    @voted_for_proc     = (@voted_for.to_f / @sum) * 100
    @voted_against_proc = (@voted_against.to_f / @sum) * 100

    #@comment = retailer_comment(current_user)


    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @retailer }
    end

  end

  def new
    @size     = ProductSize.all
    @retailer = Retailer.new

    @products = Product.all

    @retailer.build_profile

    @products.count

    @products.each do |products|
      if @retailer.price.find_by_product_id(products.id)
        products.productSize.each do |size|
        if @retailer.price.find_by_productSizes_id(size.id)
          else
            @retailer.price.build(:product_id => products.id, :productSize_id => size.id)
          end
        end
      else
        products.productSize.each do |size|
          @retailer.price.build(:product_id => products.id, :productSize_id => size.id)
        end
      end
    end


    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @retailer }
    end
  end

  def edit
    @size     = ProductSize.all
    @retailer = Retailer.find(params[:id])

    @products = Product.all

    @products.count

    @products.each do |products|
      if @retailer.price.find_by_product_id(products.id)
        products.productSize.each do |product_size|
          if @retailer.price.find_by_product_id_and_productSize_id(products.id, product_size.id)

          else
            @retailer.price.build(:product_id => products.id, :productSize_id => product_size.id)
          end
        end
      else
        products.productSize.each do |product_size|
          @retailer.price.build(:product_id => products.id, :productSize_id => product_size.id)
        end
      end
    end

  end


  def create
    @retailer = Retailer.new(params[:retailer])

    respond_to do |format|
      if @retailer.save
        format.html { redirect_to(@retailer, :notice => 'Retailer was successfully created!') }
        format.xml { render :xml => @retailer, :status => :created, :location => @retailer }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @retailer.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    @retailer = Retailer.find(params[:id])

    respond_to do |format|
      if @retailer.update_attributes(params[:retailer])
        Retailer.all.each do |retailer|
          @col = 0
          @col = count_cheapest(retailer)
          retailer.profile.update_attribute(:cheapest, @col)
        end
        format.html { redirect_to(@retailer, :notice => 'Retailer was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @retailer.errors, :status => :unprocessable_entity }
      end
    end

  end


  def destroy
    @retailer = Retailer.find(params[:id])
    @retailer.destroy

    respond_to do |format|
      format.html { redirect_to(retailers_path) }
      format.xml { head :ok }
    end
  end

  def vote_up
    if current_user
      if current_user.voted_on?(@retailer = Retailer.find(params[:id]))
        if current_user.voted_for?(@retailer = Retailer.find(params[:id]))

        else
          current_user.clear_votes(@retailer)
          current_user.vote_for(@retailer = Retailer.find(params[:id]))
          render 'like.js.erb'
        end
      else
        begin
          current_user.vote_for(@retailer = Retailer.find(params[:id]))
          render 'like.js.erb'
        rescue ActiveRecord::RecordInvalid
          render :nothing => true, :status => 404
        end
      end
    else
      render '/devise/sessions/new.js.erb'
    end
  end

  def vote_down
    if current_user
      if current_user.voted_on?(@retailer = Retailer.find(params[:id]))
        if current_user.voted_against?(@retailer = Retailer.find(params[:id]))

        else
          current_user.clear_votes(@retailer)
          current_user.vote_against(@retailer = Retailer.find(params[:id]))
          render 'like.js.erb'
        end
      else
        begin
          current_user.vote_against(@retailer = Retailer.find(params[:id]))
          render 'like.js.erb'
        rescue ActiveRecord::RecordInvalid
          render :nothing => true, :status => 404
        end
      end
    else
      render 'users/_register.js.erb'
    end
  end


  def tagged
    @tags             = Retailer.tag_counts_on(:keywords)
    @tagged_retailers = Retailer.tagged_with(params[:keyword])
    @tagged_products = Product.tagged_with(params[:keyword])
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


  private

  def comments
    if params[:id]
      if current_user
        @retailer = Retailer.find(params[:id])
        @user     = current_user
        @comment  = @user.comments.new(:retailer_id => @retailer.id)
      else
        @retailer = Retailer.find(params[:id])
        @user     = User.new
        @user.comments.build(:retailer_id => @retailer.id)
      end
    end
  end

  def count_cheapest(retailer)
    retailer.price.each do |p|
      if cheapest?(retailer, p.product, p.productSize)
        @col += 1
      end
    end
    return @col
  end

  def cheapest?(retailer, product, size)
    retailer.id == Price.select("prices.`retailer_id`, profiles.`shippingCost`, prices.`price`").joins(:retailer, :retailer => :profile).where(['product_id=? AND productSize_id=?', product.id, size.id]).group("retailers.id").order("SUM((prices.price * 1) + profiles.shippingCost)").limit(1).first.retailer.id
  end

end
