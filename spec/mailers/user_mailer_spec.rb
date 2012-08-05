require "spec_helper"

describe UserMailer do
  describe "confirm_signup" do
    let(:mail) { UserMailer.confirm_signup }

    it "renders the headers" do
      mail.subject.should eq("Confirm signup")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
