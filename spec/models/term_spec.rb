# coding: utf-8

require 'spec_helper'

describe Term do

  before(:all) do
    term = Term.new
    term.term_identifier = '1a'
    term.set_term_name
    term.term_timetable_img = "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x01,\x01,\x00\x00\xFF\xE1\x10ZExif\x00\x00MM\x00*\x00\x00\x00\b\x00\x02\x87i\x00\x04\x00\x00\x00\x01\x00\x00"
    term.term_timetable_img_content_type = "image/jpeg"
    term.save!
  end



  describe "instance methods" do

    describe "#set_term_name" do
      it "should set proper :term_name" do
        term = Term.new
        term.term_identifier = "2a"
        term.set_term_name
        term.term_name.should eq("2年前期")
      end
    end

  end



  describe "validation:" do

    before(:each) do
      @term = Term.new
      @term.term_identifier = "2a"
      @term.set_term_name
      @term.term_timetable_img = "\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x01,\x01,\x00\x00\xFF\xE1\x10ZExif\x00\x00MM\x00*\x00\x00\x00\b\x00\x02\x87i\x00\x04\x00"
      @term.term_timetable_img_content_type = "image/jpeg"
    end

    context "with valid information" do
      it "should be valid" do
        @term.should be_valid
      end
    end

    context "without :term_identifier" do
      it "should not be valid" do
        @term.term_identifier = nil
        @term.should_not be_valid
      end
    end

    context ":term_identifier is not unique" do
      it "should not be valid" do
        @term.term_identifier = "1a"
        @term.should_not be_valid
      end
    end

    context ":term_identifier has invalid format" do
      it "should not be valid" do
        @term.term_identifier = "7a"
        @term.should_not be_valid
        @term.term_identifier = "1c"
        @term.should_not be_valid
      end
    end

    context "without :term_name" do
      it "should not be valid" do
        @term.term_name = nil
        @term.should_not be_valid
      end
    end

    context "without :term_timetable_img" do
      it "should not be valid" do
        @term.term_timetable_img = nil
        @term.should_not be_valid
      end
    end

    context "without :term_timetable_img_content_type" do
      it "should not be valid" do
        @term.term_timetable_img_content_type = nil
        @term.should_not be_valid
      end
    end

    context ":term_timetable_img has invalid content_type" do
      it "should not be valid" do
        @term.term_timetable_img_content_type = "application/pdf"
        @term.should_not be_valid
      end
    end

  end

end
