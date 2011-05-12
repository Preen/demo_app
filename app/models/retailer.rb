class Retailer < ActiveRecord::Base
  validates :title, :uniqueness => true
  belongs_to :user
  has_many :price, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_one :profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :price, :reject_if => lambda { |a| a[:price].blank? }, :allow_destroy => true

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  acts_as_voteable

  acts_as_taggable
  acts_as_taggable_on :keywords

  scope :what,
        lambda { |subject| joins(:profile).order(subject) }

end
