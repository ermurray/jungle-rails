require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should be a valid user if all fields are present" do
      @user =User.create(
        name: "tester",
        email: "tester@testy.com",
        password: "badnothashed",
        password_confirmation: "badnothashed"
      )
      expect(@user).to be_valid
    end
    
    it "should be invalid if name is nil" do
      @user =User.create(
        name: nil,
        email: "tester@testy.com",
        password: "badnothashed",
        password_confirmation: "badnothashed"
      )
      expect(@user).to_not be_valid
    end
    
    it "should be invalid if email is nil" do
      @user =User.create(
        name: "tester",
        email: nil,
        password: "badnothashed",
        password_confirmation: "badnothashed"
      )
      expect(@user).to_not be_valid
    end
    
    it "should be invalid if password is nil" do
      @user =User.create(
        name: "tester",
        email: "tester@testy.com",
        password: nil,
        password_confirmation: "badnothashed"
      )
      expect(@user).to_not be_valid
    end
    
    it "should be invalid if password is less than min 5 characters" do
      @user =User.create(
        name: "tester",
        email: "tester@testy.com",
        password: 'badn',
        password_confirmation: "badn"
      )
      expect(@user).to_not be_valid
    end

    it "should be invalid if password does not match confirmation" do
      @user =User.create(
        name: "tester",
        email: "tester@testy.com",
        password: 'badnothashed',
        password_confirmation: "badnotHashed"
      )
      expect(@user).to_not be_valid
    end

    it "should be invalid if email already in use" do
      @user =User.create(
        name: "tester",
        email: "tester@testy.com",
        password: 'badnothashed',
        password_confirmation: "badnotHashed"
      )
      @user2 = User.create(
        name: "tester2",
        email: "tester@testy.com",
        password: "doesitmatter",
        password_confirmation: "doesitmatter"
      )
      expect(@user).to_not be_valid
    end  
  end
  
  describe '.authenticate_with_credentials' do

    it 'should authenticate a user' do
      @user = User.create(
        name: 'tester',
        email: 'tester@testy.com',
        password: 'testthis',
        password_confirmation: 'testthis'
      )
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end 

    it 'should authenticate a with extra space in email' do
      @user = User.create(
        name: 'tester',
        email: 'tester@testy.com',
        password: 'testthis',
        password_confirmation: 'testthis'
      )
      spaced_email = '  tester@testy.com      '
      expect(User.authenticate_with_credentials(spaced_email, @user.password)).to eq(@user)
    end 

    it 'should authenticate a with wrong casing in email' do
      @user = User.create(
        name: 'tester',
        email: 'tester@testy.com',
        password: 'testthis',
        password_confirmation: 'testthis'
      )
      cased_email = 'TESTER@tesTy.COM'
      expect(User.authenticate_with_credentials(cased_email, @user.password)).to eq(@user)
    end 


  end

end
