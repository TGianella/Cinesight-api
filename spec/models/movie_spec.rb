require 'rails_helper'

RSpec.describe Movie do
  it 'creates a record in the database' do
    movie = Movie.new(id: 1, title: 'test')
    expect(movie.save).to be true
  end

  it "doesn't create a record in the database if no ID is specified" do
    movie = Movie.new(title: 'test')
    expect { movie.save }.to raise_error ActiveRecord::NotNullViolation
  end

  it "doesn't create a record in the database if no title is specified" do
    movie = Movie.new(id: 1)
    expect { movie.save }.to raise_error ActiveRecord::NotNullViolation
  end

  it "doesn't create a record in the database if ID is not unique" do
    movie1 = Movie.create(id: 1, title: 'test')
    movie2 = Movie.new(id: 1, title: 'test')
    expect { movie2.save }.to raise_error ActiveRecord::RecordNotUnique
  end
end
