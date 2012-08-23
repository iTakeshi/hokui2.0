# coding: utf-8

require 'spec_helper'

describe Material do
  describe 'validation:' do

    before(:all) do
      @subject = Subject.new
      @subject.term_identifier = '1a'
      @subject.subject_identifier = 'physics'
      @subject.subject_name = '物理学'
      @subject.subject_staff = '名前或蔵'
      @subject.subject_lct_cd = '020203'
      @subject.subject_syllabus_html = '<html></html>'
      @subject.save!

      material = @subject.materials.new
      material.user_id = 1
      material.material_type = 0
      material.material_year = 93
      material.material_number = 1
      material.material_with_answer = true
      material.get_page
      material.material_comments = 'abc'
      material.material_file_name = '物理学93-1-a-1'
      material.material_file_ext = 'pdf'
      material.material_file_content_type = 'application/pdf'
      material.material_download_count = 0
      material.save!
    end

    before(:each) do
      @material = @subject.materials.new
      @material.user_id = 1
      @material.material_type = 0
      @material.material_year = 93
      @material.material_number = 1
      @material.material_with_answer = true
      @material.get_page
      @material.material_comments = 'abc'
      @material.material_file_name = '物理学93-1-a-2'
      @material.material_file_ext = 'pdf'
      @material.material_file_content_type = 'application/pdf'
      @material.material_download_count = 0
      @material.save!
    end

    context "with valid information" do
      it "should be valid" do
        @material.should be_valid
      end
    end

    context "without :subject_identifier" do
      it "should not be valid" do
        @material.subject_identifier = nil
        @material.should_not be_valid
      end
    end

    context "without :user_id" do
      it "should not be valid" do
        @material.user_id = nil
        @material.should_not be_valid
      end
    end

    context "without :material_type" do
      it "should not be valid" do
        @material.material_type = nil
        @material.should_not be_valid
      end
    end

    context "without :material_year" do
      it "should not be valid" do
        @material.material_year = nil
        @material.should_not be_valid
      end
    end

    context "without :material_number" do
      it "should not be valid" do
        @material.material_number = nil
        @material.should_not be_valid
      end
    end

    context "without :material_with_answer" do
      it "should not be valid" do
        @material.material_with_answer = nil
        @material.should_not be_valid
      end
    end

    context "without :material_page" do
      it "should not be valid" do
        @material.material_page = nil
        @material.should_not be_valid
      end
    end

    context "without :material_comments" do
      it "should be valid" do
        @material.material_comments = nil
        @material.should be_valid
      end
    end

    context "without :material_file_name" do
      it "should not be valid" do
        @material.material_file_name = nil
        @material.should_not be_valid
      end
    end

    context ":material_file_name is not unique" do
      it "should not be valid" do
        @material.material_file_name = "物理学93-1-a-1"
        @material.should_not be_valid
      end
    end

    context "without :material_file_ext" do
      it "should not be valid" do
        @material.material_file_ext = nil
        @material.should_not be_valid
      end
    end

    context "without :material_file_content_type" do
      it "should not be valid" do
        @material.material_file_content_type = nil
        @material.should_not be_valid
      end
    end

    context "without :material_download_count" do
      it "should not be valid" do
        @material.material_download_count = nil
        @material.should_not be_valid
      end
    end

  end

end
