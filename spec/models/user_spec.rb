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

  it 'can properly own a watchlist' do
    subject = described_class.create(email: 'test@test.com', password: 'foobar')
    watchlist = Watchlist.create(user: subject)
    expect(watchlist.user).to eq subject
  end
end
