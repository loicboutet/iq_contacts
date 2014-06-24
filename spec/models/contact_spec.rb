require 'rails_helper'

RSpec.describe Contact, :type => :model do


  describe "Contact Validation" do
    it "require a first and last name" do
      c = Contact.create
      expect(c.errors.messages[:first_name].size).to eq 1
      expect(c.errors.messages[:last_name].size).to eq 1
    end

    it "require a user_id" do
      c = Contact.create
      expect(c.errors.messages[:user_id].size).to eq 1
    end
  end

  describe "Contact Geocoding" do
    before(:each) do
      @user = User.create(:email => "test@example.com", :password => "testtest", :password_confirmation => "testtest")
      @contact = Contact.new(:first_name => "first", :last_name => "last", :user => @user)
    end

    it "does not geocode if there is no address" do
      @contact.save
      expect(@contact.lng).to be_nil
      expect(@contact.lat).to be_nil
    end

    it "does geocode if there is an address" do
      @contact.address_city = "Paris"
      @contact.address_country = "France"
      @contact.save
      expect(@contact.lng).to_not be_nil
      expect(@contact.lat).to_not be_nil
    end

    it "does not geocode when the address is unknown" do
      @contact.address_city = "dqjlkdq"
      @contact.address_country = "dqsdqdqs"
      @contact.save
      expect(@contact.lng).to be_nil
      expect(@contact.lat).to be_nil
    end
  end

  describe "Contact Search" do

    before(:each) do
      @user = User.create(:email => "test@example.com", :password => "testtest", :password_confirmation => "testtest")
      @contact = Contact.create(:first_name => "first", :last_name => "last", :user => @user)
    end

    it "does search on contact attributes" do
      expect(Contact.search("first")).to include(@contact)
    end

    it "does search on contact attributes even if they are mispelled" do
      expect(Contact.search("frst")).to include(@contact)
    end

    it "does search on contact tag_list even if they are mispelled" do
      expect(Contact.search("work")).to_not include(@contact)
      @contact.tag_list = "work, friend"
      @contact.save
      expect(Contact.search("work")).to include(@contact)
    end

  end

end
