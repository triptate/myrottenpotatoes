require 'rails_helper.rb'

describe Movie do

  it 'should include rating and year in full name' do
    ## Version that uses fixtures:
    # fixtures :movies
    # movie = movies(:milk_movie)
    # expect(movie.name_with_rating).to eq('Milk (R)')

    ## Version that uses factories (verbose):
    movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R')
    expect(movie.name_with_rating).to eq('Milk (R)')

    ## Version that uses factories (concise):
    ### CAN'T GET THIS ONE TO WORK ###
    ### PROBLEM WITH 'ITS' GEM ###
    # subject { build :movie, :title => 'Milk', :rating => 'R' }.
    # its(:name_with_rating) { is_expected.to eq('Milk (R)') }
  end

  describe 'Searching Tmdb by keyword' do

  	context 'with valid API key' do
	  it 'should call Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end

    context 'with invalid API key' do
      before :each do
      	allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)
        allow(Tmdb::Api).to receive(:response).and_return({'code' => 401})
      end
      it 'should raise an InvalidKeyError' do
        expect { Movie.find_in_tmdb('Inception') }.
          to raise_error(Movie::InvalidKeyError)
      end
    end

  end

end