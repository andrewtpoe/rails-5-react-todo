require "rails_helper"

RSpec.describe User do
  let(:user) { User.create(email: "first@gmail.com", password: "password") }
  let(:user_two) { User.create(email: "second@gmail.com", password: "password") }

  context "is not valid if" do
    it "does not have any email" do
      user.email = ""
      expect(user).not_to be_valid
      expect(user.save).to be false
    end

    it "does not have unique email" do
      user.email = user_two.email
      expect(user).not_to be_valid
      expect(user.save).to be false
    end

    it "does not have any password" do
      user.password = ""
      expect(user).not_to be_valid
      expect(user.save).to be false
    end

    it "has a password less than 8 characters long" do
      user.password = "fail"
      expect(user).not_to be_valid
      expect(user.save).to be false
    end
  end
end
