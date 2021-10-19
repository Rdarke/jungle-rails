require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it "credentials are present & valid" do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user).to be_valid
    end

    it "should not save when first name is invalid" do
      user = User.new(first_name: nil)
      expect(user).to be_invalid
    end

    it "should not save when last name is invalid" do
      user = User.new(last_name: nil)
      expect(user).to be_invalid
    end

    it "should not save when email is invalid" do
      user = User.new(email: nil)
      expect(user).to be_invalid
    end

    it "should be invalid if password do not match" do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'notTheSame'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it 'user should hold a unique email' do
      user1 = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'testing'
      )

      user1.save
    
      user2 = User.new(
        first_name: 'User',
        last_name: 'Two',
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user2.save
    
      expect(user2.errors[:email].first).to eq('has already been taken')
    end

    it 'should have 6 or more characters within the password' do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      expect(user).to be_invalid
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should not allow invalid credentials' do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      user = User.authenticate_with_credentials('notCorrect@test.com', 'wrongPassword')
      expect(user).to be(nil)
    end

    it 'should allow spaces within an email' do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      user = User.authenticate_with_credentials('user1@test.com  ', 'testing')
      expect(user).not_to be(nil)
    end

    it 'should be case insensative within the email' do
      user = User.new(
        first_name: 'User',
        last_name: 'One',
        email: 'user1@test.com',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      user = User.authenticate_with_credentials('USER1@test.com', 'testing')
      expect(user).not_to be(nil)
    end
  end
  
end
