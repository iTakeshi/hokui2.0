require "spec_helper"

describe AdminMailer do
  describe "notify_signup_request" do
    let(:mail) { AdminMailer.notify_signup_request }

    it "renders the headers" do
      mail.subject.should eq("Notify signup request")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
