require_relative '../rails_helper'

RSpec.describe User, type: :model do
  it 'does not be validate with blank fields' do
    user = User.new
    expect(user.save).to be false
  end

  it 'should be validate' do
    user = User.new(email: 'jean-bonneau@test.fr', password: 'foobar')
    expect(user.save).to be true
    user.destroy
  end

  it 'does not be validate short password' do
    user = User.new(email: 'jean-bonneau@test.fr', password: 'foo')
    expect(user.save).to be false
  end

  it 'does not be validate invalid email' do
    user = User.new(email: 'jean-bonneau', password: 'foobar')
    expect(user.save).to be false
  end
end
