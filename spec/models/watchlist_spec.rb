require 'rails_helper'

RSpec.describe Watchlist do
  before do
    @user = User.create(email: 'test@test.com', password: 'foobar')
    @movie = Movie.create(id: 1, title: 'test')
  end

  it 'creates a record in the database' do
    subject = @user.watchlist
    expect(subject.save).to be true
  end

  it "doesn't create a record in the database if no user is specified" do
    subject = described_class.new
    expect(subject.save).to be false
  end

  it 'properly belongs to an user' do
    subject = @user.watchlist
    expect(@user.watchlist).to eq subject
  end

  it 'can belong to movies' do
    subject = @user.watchlist
    subject.movies << @movie
    expect(@movie.watchlists).to include subject
  end

  it 'cannot have duplicates of the same movie' do
    subject = @user.watchlist
    subject.movies << @movie
    expect { subject.movies << @movie }.to raise_error ActiveRecord::RecordNotUnique
  end
end
