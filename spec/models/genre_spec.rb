require 'rails_helper'

RSpec.describe Genre do
  before do
    @movie = Movie.create(id: 1, title: 'test')
  end

  it 'creates a record in the database' do
    subject = described_class.new(id: 1, name: 'test')
    expect(subject.save).to be true
  end

  it "doesn't create a record in the database if no name is specified" do
    subject = described_class.new(id: 1)
    expect { subject.save }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'can belong to movies' do
    subject = described_class.create(id: 1, name: 'test', movies: [@movie])
    expect(@movie.genres).to include subject
  end

  it 'cannot have duplicates of the same movie' do
    subject = described_class.create(id: 1, name: 'test', movies: [@movie])
    expect { subject.movies << @movie }.to raise_error ActiveRecord::RecordNotUnique
  end
end
