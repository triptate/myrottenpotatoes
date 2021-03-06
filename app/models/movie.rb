class Movie < ActiveRecord::Base

  def self.all_ratings; %w[G PG PG-13 R NC-17]; end # shortcut for an array of strings

  has_many :reviews
  has_many :moviegoers, :through => :reviews

  attr_accessible :title, :director, :rating, :description, :release_date
  
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

  class Movie::InvalidKeyError < StandardError ; end

  def self.find_in_tmdb(string)
    begin
      Tmdb::Movie.find(string)
    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response['code'] == 401
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
  end

  scope :search, lambda { |search|
    if search.present?
      rating_search(search).keyword_search(search).director_search(search)
    else
      scoped
    end
  }
  scope :rating_search, lambda { |search|
    ratings = search[:rating] ? search[:rating] : all_ratings
    where(:rating => ratings)
  }
  scope :keyword_search, lambda { |search|
    where("title LIKE ?", "%#{search[:keywords]}%")
  }
  scope :director_search, lambda { |search|
    if search[:director].present?
      where("director LIKE ?", "%#{search[:director]}%")
    else
      all
    end
  }
  scope :with_good_reviews, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id).having(['AVG(reviews.potatoes) > ?', threshold.to_i])
  }
  scope :for_kids, lambda {
    Movie.where('rating in (?)', %w(G PG))
  }
  scope :recently_reviewed, lambda { |n|
    Movie.joins(:reviews).where(['reviews.created_at >= ?', n.days.ago]).uniq
  }


end
