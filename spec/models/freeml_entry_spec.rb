require 'spec_helper'

describe FreemlEntry do
  describe 'validation:' do

    before(:all) do
      entry = FreemlEntry.new(
        freeml_id: 100,
        freeml_user: 'hoge',
        freeml_body: 'hello',
        freeml_title: 'hello',
        freeml_datetime: Time.now,
        freeml_readable: true
      )
      entry.save!
    end

    before(:each) do
      @entry = FreemlEntry.new(
        freeml_id: 101,
        freeml_user: 'fuga',
        freeml_body: 'bye',
        freeml_title: 'bye',
        freeml_datetime: Time.now,
        freeml_readable: false
      )
    end

    context "with valid information" do
      it "should be valid" do
        @entry.should be_valid
      end
    end

    context "without :freeml_id" do
      it "should not be valid" do
        @entry.freeml_id = nil
        @entry.should_not be_valid
      end
    end

    context ":freeml_id is not unique" do
      it "should not be valid" do
        @entry.freeml_id = 100
        @entry.should_not be_valid
      end
    end

    context "without :freeml_user" do
      it "should not be valid" do
        @entry.freeml_user = nil
        @entry.should_not be_valid
      end
    end

    context "without :freeml_body" do
      it "should not be valid" do
        @entry.freeml_body = nil
        @entry.should_not be_valid
      end
    end

    context "without :freeml_title" do
      it "should not be valid" do
        @entry.freeml_title = nil
        @entry.should_not be_valid
      end
    end

    context "without :freeml_datetime" do
      it "should not be valid" do
        @entry.freeml_datetime = nil
        @entry.should_not be_valid
      end
    end

    context "without :freeml_readable" do
      it "should not be valid" do
        @entry.freeml_readable = nil
        @entry.should_not be_valid
      end
    end

  end
end
