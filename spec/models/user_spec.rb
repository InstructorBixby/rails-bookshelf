require 'rails_helper'

describe User do
  it 'is valid from the factory' do
    expect(build(:user)).to be_valid
  end

  it 'needs an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'will not take the same email twice' do
    create(:user, email: 'a@example.com')
    expect(build(:user, email: 'a@example.com')).not_to be_valid
  end

  it 'downcases the email' do
    u = create(:user, email: 'MixedCase@Example.COM')
    expect(u.email).to eq('mixedcase@example.com')
  end

  it 'authenticates with the right password' do
    u = create(:user, password: 'swordfish')
    expect(u.authenticate('swordfish')).to eq(u)
  end

  it 'does not authenticate with the wrong one' do
    u = create(:user, password: 'swordfish')
    expect(u.authenticate('nope')).to be false
  end
end
