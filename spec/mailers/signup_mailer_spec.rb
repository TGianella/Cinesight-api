require_relative '../rails_helper'

RSpec.describe SignupMailer do
  describe 'signup mailer' do
    it 'sends an email at signup' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      expect(described_class.deliveries.count).to eq(1)
    end

    it 'sends an email to the user' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      expect(described_class.deliveries.first.to).to eq(['test@mail.fr'])
    end

    it 'sends an email from the correct address' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      expect(described_class.deliveries.first.from).to eq(['saeros@yopmail.com'])
    end
  end
end
