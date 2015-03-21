# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.new(movie).save
  end
end

# Make sure that one string (regexp) occurs before or after another one
# on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.find('#movies tbody').assert_text(/#{e1}.*#{e2}/m)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  convert_to_array(rating_list).each do |rating|
    steps %Q{
      When I #{uncheck}check "rating[#{rating}]"
    }
  end
end

# Make it easier to assert that movies with certain ratings appear on the page
#  "I should see movies rated: G, R"
#  "I should not see movies rated: PG, PG-13, NC-17"

Then /I should (not )?see movies rated: (.*)/ do |negative_assertion, rating_list|
  Movie.where(:rating => convert_to_array(rating_list)).each do |movie|
    if negative_assertion
      page.find('#movies tbody').assert_no_text(movie.title)
    else
      page.find('#movies tbody').assert_text(movie.title)
    end
  end
end

# In the special case that you're searching all the movies, we can simply check
# that there are the same number of rows in the movies table on the page as there
# are rows in the movies database.

Then /I should see all the movies/ do
  expect(all('#movies tbody tr').count).to eq(Movie.all.count)
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_title, director|
  movie = Movie.find_by_title movie_title
  expect(movie.director).to eq(director)
end

# helper methods below

def convert_to_array(rating_list)
  ratings = []
  rating_list.split(%r{,\s*}).each do |rating|
    ratings << rating
  end
end