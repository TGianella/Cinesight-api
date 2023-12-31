require 'rails_helper'

RSpec.describe Movie do
  it 'creates a record in the database' do
    movie = described_class.new(id: 1, title: 'test')
    expect(movie.save).to be true
  end

  it "doesn't create a record in the database if no ID is specified" do
    movie = described_class.new(title: 'test')
    expect { movie.save }.to raise_error ActiveRecord::NotNullViolation
  end

  it "doesn't create a record in the database if no title is specified" do
    movie = described_class.new(id: 1)
    expect { movie.save }.to raise_error ActiveRecord::NotNullViolation
  end

  it "doesn't create a record in the database if ID is not unique" do
    described_class.create(id: 1, title: 'test')
    movie = described_class.new(id: 1, title: 'test')
    expect { movie.save }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'can belong to a watchlist' do
    user = User.create(email: 'test@test.com', password: 'foobar')
    watchlist = user.watchlist
    subject = described_class.create(id: 1, title: 'test', watchlists: [watchlist])
    expect(watchlist.movies).to include subject
  end

  it 'can belong to a genre' do
    genre = Genre.create(id: 1, name: 'test')
    subject = described_class.create(id: 1, title: 'test', genres: [genre])
    expect(genre.movies).to include subject
  end
end
