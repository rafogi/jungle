require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'validates the user' do
      @user = User.new(name: "batman", email: "a@a.com", password: "1234567", password_confirmation: "1234567")
      @user.valid?
      expect(@user.errors.full_messages.length).to eq(0)
    end

    it 'shows error message without name' do
      @user = User.new(name: nil, email: "a@a.com", password: "1234567", password_confirmation: "1234567")
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'shows error message without email' do
      @user = User.new(name: "batman", email:nil, password: "1234567", password_confirmation: "1234567")
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'shows error message when email is not unique' do
      @user1 = User.new(name: "batman", email:"a@a.com", password: "1234567", password_confirmation: "1234567")
      @user1.save!
      @user2 = User.new(name: "batman", email:"a@a.com", password: "1234567", password_confirmation: "1234567")
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'shows error message when password is blank' do
      @user = User.new(name: "batman", email:"a@a.com", password: nil, password_confirmation: "1234567")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'shows error message when password fields doesn"t match' do
      @user = User.new(name: "batman", email:"a@a.com", password: '7654321', password_confirmation: "1234567")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'shows error message when password is less than 7 characters' do
      @user = User.new(name: "batman", email:"a@a.com", password: '123', password_confirmation: "123")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 7 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'logs them in if user and password match' do
      @user = User.new(name: "batman", email:"a@a.com", password: '1234567', password_confirmation: "1234567")
      @user.save!
      expect(User.authenticate_with_credentials("a@a.com", "1234567")).to be_present
    end

    it 'logs them in if email has upper case' do
      @user = User.new(name: "batman", email:"a@a.com", password: '1234567', password_confirmation: "1234567")
      @user.save!
      expect(User.authenticate_with_credentials("A@a.com", "1234567")).to be_present
    end

    it 'logs them in if user has white spaces' do
      @user = User.new(name: "batman", email:"a@a.com", password: '1234567', password_confirmation: "1234567")
      @user.save!
      expect(User.authenticate_with_credentials("  A@a.com", "1234567")).to be_present
    end
  end

end