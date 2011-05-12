class Product < ActiveRecord::Base
  validates :title, :uniqueness => true
  belongs_to :user
  has_many :prices, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :productSize
  has_and_belongs_to_many :categories

  has_attached_file :photo,
  :styles => {
    :thumb=> "100x100#",
    :small  => "125x125>",
    :medium => "300x300>",
    :large =>   "400x400>" }

  #  * DO NOT forget to redo the slugs, or else this feature will not work!
  #  * This feature uses attr_protected to protect the cached_slug column, unless you have already invoked attr_accessible. If you wish to use attr_accessible, you must invoke it BEFORE you invoke has_friendly_id in your class.
  #  * Cached slugs are incompatible with scopes and are ignored if your model uses the :scope option.

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  def product_categories
    Product.find(params[:id]).categories
  end

  scope :what_scope,
        lambda { |subject,ordering| joins(:productSize, :categories).group(subject).order(ordering)}


end
