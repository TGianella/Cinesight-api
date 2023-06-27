require_relative '../rails_helper'

RSpec.describe User do
  it 'does not be validate with blank fields' do
    user = described_class.new
    expect(user.save).to be false
  end

  it 'creates a user' do
    user = described_class.new(email: 'jean-bonneau@test.fr', password: 'foobar')
    expect(user.save).to be true
    user.destroy
  end

  it 'does not validate with a short password' do
    user = described_class.new(email: 'jean-bonneau@test.fr', password: 'foo')
    expect(user.save).to be false
  end

  it 'does not validate with invalid email' do
    user = described_class.new(email: 'jean-bonneau', password: 'foobar')
    expect(user.save).to be false
  end

  it 'automatically creates watchlist on creation' do
    subject = described_class.create(email: 'test@test.com', password: 'foobar')
    expect(subject.watchlist).not_to be_nil
  end

  it 'cannot have two watchlists' do
    subject = described_class.create(email: 'test@test.com', password: 'foobar')
    expect { Watchlist.create(user: subject) }.to raise_error ActiveRecord::RecordNotUnique
  end
end
