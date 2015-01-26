class Movie < ActiveRecord::Base

  has_many :reviews
  has_many :moviegoers, :through => :reviews

  def self.all_ratings; %w[G PG PG-13 R NC-17]; end # shortcut for an array of strings

  validates :title, :presence => true
  validates :release_date, :presence => true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, :inclusion => {:in => Movie.all_ratings}, :unless => :grandfathered?
  validates :rating, :absence => { :message => 'must be empty if movie predates rating system'},
  	:if => :grandfathered?

  def released_1930_or_later
  	if release_date && release_date < Date.parse('1 Jan 1930')
  	  errors.add(:release_date, 'must be 1930 or later')
  	end
  end

  @@grandfathered_date = Date.parse('1 Nov 1968')
  def grandfathered?
  	release_date && release_date < @@grandfathered_date
  end

  def name_with_rating
    title + ' (' + rating + ')'
  end

  scope :with_good_reviews, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id).having(['AVG(reviews.potatoes) > ?', threshold.to_i])
  }

  scope :for_kids, lambda {
    Movie.where('rating in (?)', %w(G PG))
  }

  scope :recently_reviewed, lambda { |n|
    Movie.joins(:reviews).where(['reviews.created_at >= ?', n.days.ago]).uniq
  }

  attr_accessible :title, :rating, :description, :release_date

end
