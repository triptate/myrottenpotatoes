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
    # subject { build :movie, :title => 'Milk', :rating => 'R' }.
    # its(:name_with_rating) { is_expected.to eq('Milk (R)') }
  end

end