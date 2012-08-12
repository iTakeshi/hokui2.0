# coding: utf-8

require 'spec_helper'

describe Subject do

  describe "instance methods" do

    describe "#get_subject_information" do
      it "should get proper informations" do
        subject = Subject.new
        subject.term_identifier = '1a'
        subject.subject_syllabus_html = <<EOF
<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" ><HTML><HEAD><title>授業詳細</title></HEAD><body bgColor=\"#e8ebd7\"><form name=\"Form1\" method=\"post\" action=\"DetailMain.aspx\" id=\"Form1\"><input type=\"hidden\" name=\"__EVENTVALIDATION\" id=\"__EVENTVALIDATION\" value=\"/wEWAgKQp+DwBAL+6YyoCmVhyaKTVEROehs+4CWTiCY34Ua9\" /><TABLE id=\"Table3\" style=\"Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px\" height=\"100%\"cellSpacing=\"0\" cellPadding=\"0\" width=\"100%\" border=\"0\"><TBODY><TR><!-- header start--><TD vAlign=\"top\"><a name=\"page_top\" id=\"page_top\"></a><table id=\"bhHeader_TableHeader3\" height=\"140\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\"><tr><TD valign=\"top\" align=\"left\"><IMG height=\"40\" alt=\"\" src=\"common_images/spacer.gif\" width=\"40\"></TD><TD class=\"medium_bb_t\" valign=\"middle\" align=\"right\"><span id=\"bhHeader_lblNow3\">2012/08/12 14:09:02</span><IMG height=\"1\" alt=\"\" src=\"common_images/spacer.gif\" width=\"40\">
</TD></tr><tr><TD valign=\"top\" align=\"left\" background=\"common_images/hu_title_back.jpg\"><IMG alt=\"北海道大学タイトル\" src=\"common_images/hu_title_left_l.jpg\" width=\"380\"></TD><TD valign=\"top\" align=\"right\" background=\"common_images/hu_title_back.jpg\"><IMG alt=\"北海道大学タイトル\" src=\"common_images/hu_title_right_l.jpg\" width=\"620\"></TD></tr><tr><TD>&nbsp;</TD><TD>&nbsp;</TD></tr><tr><TD colspan=\"2\"><TABLE width=\"100%\"><TR><TD align=\"left\"><IMG height=\"1\" alt=\"\" src=\"common_images/spacer.gif\" width=\"40\"><span id=\"bhHeader_smp\"><a href=\"#bhHeader_smp_SkipLink\"><img alt=\"ナビゲーション リンクのスキップ\" height=\"0\" width=\"0\" src=\"/Syllabus/WebResource.axd?d=q4WxT9C_t47UrJy-14zaNLiLMebIjiOgFI_v1CGECD5Mi_t7nk29UWM-8ehFd8QZyXmHftWUprZ119zlmYMH2-d62sI1&amp;t=634752439818036951\" style=\"border-width:0px;\" /></a><span><a title=\"シラバス検索\" href=\"/Syllabus/App/Search/SearchMain.aspx\">シラバス検索</a></span><span> &gt; </span><span><a title=\"シラバス検索結果\" href=\"/Syllabus/App/Search/SearchList.aspx\">
シラバス検索結果</a></span><span> &gt; </span><span>授業詳細</span><a id=\"bhHeader_smp_SkipLink\"></a></span></TD><TD align=\"right\"></TD></TR></TABLE></TD></tr></table></TD><!-- header end--></TR><TR><!--conts start--><TD vAlign=\"top\" align=\"center\"><BR><TABLE id=\"Table1\" cellSpacing=\"0\" cellPadding=\"0\" width=\"95%\" align=\"center\" border=\"0\"><TR><TD align=\"right\"><input type=\"submit\" name=\"btnPrint\" value=\"印刷用ページ\" onclick=\"syllabus_print_window('Print.aspx?');return false;\" language=\"javascript\" id=\"btnPrint\" /><IMG height=\"6\" alt=\"\" src=\"common_images/spacer.gif\" width=\"12\"></TD></TR><TR><TD align=\"center\"><style>.syl_contents { LINE-HEIGHT: 150% }    .style1    {        height: 44px;    }</style><TABLE id=\"Table1\" cellSpacing=\"0\" cellPadding=\"0\" width=\"992\" border=\"0\"><TR><TD><TABLE id=\"Table5\" cellSpacing=\"0\" cellPadding=\"0\" width=\"992\" border=\"0\"><TR><TD><IMG height=\"20\" alt=\"\" src=\"../../common_images/spacer.gif\" width=\"40\">
</TD><TD><FONT face=\"MS UI Gothic\"></FONT></TD><TD><IMG height=\"20\" alt=\"\" src=\"../../common_images/spacer.gif\" width=\"40\"></TD></TR><TR><TD></TD><TD><TABLE id=\"Table6\" cellSpacing=\"0\" borderColorDark=\"#006600\" cellPadding=\"4\" rules=\"all\"width=\"912\" bgColor=\"#8dc73f\" borderColorLight=\"#8dc73f\" border=\"1\"><TR><TD bgColor=\"#48851d\" colSpan=\"6\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblSbjName\">科目名［英文名］ Course Title</span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\" colSpan=\"6\"><span id=\"Detail_lbl_sbj_name\">解剖学（組織学）</span>&nbsp;&nbsp;<span id=\"Detail_lbl_sbj_name_e\">[Anatomy(Histology)]</span></TD></TR><TR><TD bgColor=\"#48851d\" colSpan=\"6\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblThemeName\">講義題目 Subtitle</span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\" colSpan=\"6\"><span id=\"Detail_lbl_theme_name\"></span>&nbsp;&nbsp;<span id=\"Detail_lbl_theme_name_e\">
</span></TD></TR><TR><TD bgColor=\"#48851d\" colSpan=\"6\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblAdminStaffAlias\">責任教員［ローマ字表記］（所属） Instructor(Institution)</span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\" colSpan=\"6\"><span id=\"Detail_lbl_admin_staff_alias\">岩永　敏彦[Toshihiko IWANAGA](医学研究科)</span>&nbsp;</TD></TR><TR><TD bgColor=\"#48851d\" colSpan=\"6\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblStaffName\">担当教員［ローマ字表記］（所属） Other Instructors(Institution)</span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\" colSpan=\"6\"><span id=\"Detail_lbl_staff_name\">岩永　敏彦[Toshihiko IWANAGA](医学研究科)</span>&nbsp;</TD></TR><TR><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblSbjSortName\">科目種別</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblSbjSortNameE\">Course Type</span></FONT></TD><TD bgColor=\"#e8ebd7\" colSpan=\"3\">
<span id=\"Detail_lbl_sbj_sort_name\">医学科</span>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblOtherFac\">他学部履修等の可否</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblOtherFacE\">Open To Other Faculties / Schools</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblOtherFacECR\"></span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_other_fac_name\">不可</span>&nbsp;&nbsp;</TD></TR><TR><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblLctYear\">開講年度<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year</span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_lct_year\">2012</span>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblLctTermName\">開講学期</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblLctTermNameE\">
Semester</span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_lct_term_name\">１学期</span>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblLctCd\">時間割番号<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Course Number</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblLctCdE\"></span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_lct_cd\">021689</span>&nbsp;&nbsp;</TD></TR><TR><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><FONT color=\"#ffffff\"><span id=\"Detail_lblTypeName\">授業形態</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblTypeNameE\">Type of Class</span></FONT></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_type_name\">講義</span>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><FONT color=\"#ffffff\">
<span id=\"Detail_lblCredits\">単位数</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblCreditsE\">Number of Credits</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblCreditsECR\"></span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_credits\">2</span>&nbsp;<FONT color=\"#ffffff\"></FONT>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblGrad\">対象年次</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblGradE\">Year of Eligible Students</span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_grad_min\">2</span>～<span id=\"Detail_lbl_grad_max\">2</span>&nbsp;</TD></TR><TR><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblClassName\">対象学科･クラス</span> <br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblClassNameE\">Eligible Department/Class</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblClassNameECR\">
</span></FONT></TD><TD bgColor=\"#e8ebd7\" colSpan=\"3\"><span id=\"Detail_lbl_class_name\">医学科</span>&nbsp;</TD><TD bgColor=\"#48851d\"><FONT color=\"#ffffff\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblSylNote\">補足事項</span><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id=\"Detail_lblSylNoteE\">Other Information</span></FONT></TD><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_syl_note\"></span></TD></TR></TABLE></TD><TD></TD></TR></TABLE></TD></TR><TR><TD></TD></TR><TR><TD><IMG height=\"20\" alt=\"\" src=\"../../common_images/spacer.gif\" width=\"20\"></TD></TR><TR><TD align=\"center\"><TABLE id=\"Table4\" cellSpacing=\"0\" cellPadding=\"4\" width=\"800\" bgColor=\"#8dc73f\" border=\"0\"><TR><TD bgColor=\"#8dc73f\"><FONT><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblKeywordDP\">キーワード Key Words</span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_keyword\" class=\"syl_contents\"></span></TD></TR><TR><TD bgColor=\"#e8ebd7\">
&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><FONT><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblAim\">授業の目標 Course Objectives </span></FONT></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_aim\" class=\"syl_contents\">人体の正常構造を顕微鏡レベルで理解するを使って理解する。</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblTarget\">到達目標 Course Goals</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_target\" class=\"syl_contents\">1. 上皮、結合、軟骨、骨、筋、神経の各組織の形態および機能特性を説明できる。<br>4. 肝臓、腎臓など諸器官の顕微鏡レベルの構造を説明し、機能との関係を説明できる。<br></span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblSchedule\">授業計画 Course Schedule</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_schedule\" class=\"syl_contents\">1-2. 上皮組織と腺組織<br>3-4. 結合組織、軟骨組織<br>5. 骨組織
<br>6-7. 筋組織<br>8-9. 神経組織<br>10. 血液<br>11-12. 循環器（血管、心臓）<br>13. 造血器（骨髄、胸腺）<br>14. 免疫系（リンパ節、扁桃、脾臓）<br>15. 皮膚、皮膚の付属器（爪、毛）<br>16. 口腔（舌、歯）<br>17-18. 消化管（唾液腺、食道から大腸）<br>19. 肝・胆・膵<br>20-21. 呼吸器（鼻腔、気管、肺）<br>22-23. 内分泌器<br>24. 泌尿器<br>25-26. 男性生殖器<br>27-28. 女性生殖器<br>29. 視覚器<br>30. 平衡・聴覚器<br></span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblPrestudy\">準備学習（予習・復習）等の内容と分量 Homework</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_pre_study\" class=\"syl_contents\">参考書と講義プリントを使って予習・復習を行う。</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblGrading\">成績評価の基準と方法 Grading System</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_grading\" class=\"syl_contents\">筆記試験による。</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\">
<IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblTextBook\">テキスト・教科書 Textbooks</span></TD></TR><TR><TD bgColor=\"#e8ebd7\" class=\"style1\"><span id=\"Detail_lbl_text_book\" class=\"syl_contents\">使用しない</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblReferenceBook\">講義指定図書 Reading List</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_reference_book\" class=\"syl_contents\">標準組織学（総論・各論） / 藤田尚男、藤田恒夫 : 医学書院<br>組織学 / 伊藤隆 : 南山堂<br>カラーアトラス組織・細胞学 / 岩永敏彦 : 医歯薬出版</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblUrl\">参照ホームページ Websites</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_url1\" class=\"syl_contents\"></span><br><span id=\"Detail_lbl_url2\" class=\"syl_contents\"></span><br><span id=\"Detail_lbl_url3\" class=\"syl_contents\">
</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblWebsite\">研究室のホームページ Website of Laboratory </span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_website\" class=\"syl_contents\"></span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblNote\">備考 Additional Information</span>&nbsp;</TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_note\" class=\"syl_contents\"></span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR><TR><TD bgColor=\"#8dc73f\"><IMG alt=\"\" src=\"../../common_images/mark_ore.gif\"><span id=\"Detail_lblUpdateDt\">更新日時 Update</span></TD></TR><TR><TD bgColor=\"#e8ebd7\"><span id=\"Detail_lbl_update_dt\" class=\"syl_contents\">2012/01/06 18:49:03</span></TD></TR><TR><TD bgColor=\"#e8ebd7\">&nbsp;</TD></TR></TABLE></TD></TR></TABLE>
</TD></TR></TABLE><BR></TD><!--conts end--></TR><TR><!-- foota start--><TD vAlign=\"bottom\"><table id=\"bfFooter_TableFooter3\" height=\"150\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\"><tr><TD colspan=\"2\"><TABLE width=\"100%\"><TR><TD align=\"left\" valign=\"top\"><IMG height=\"1\" alt=\"\" src=\"common_images/spacer.gif\" width=\"40\"><span id=\"bfFooter_smp\"><a href=\"#bfFooter_smp_SkipLink\"><img alt=\"ナビゲーション リンクのスキップ\" height=\"0\" width=\"0\" src=\"/Syllabus/WebResource.axd?d=q4WxT9C_t47UrJy-14zaNLiLMebIjiOgFI_v1CGECD5Mi_t7nk29UWM-8ehFd8QZyXmHftWUprZ119zlmYMH2-d62sI1&amp;t=634752439818036951\" style=\"border-width:0px;\" /></a><span><a title=\"シラバス検索\" href=\"/Syllabus/App/Search/SearchMain.aspx\">シラバス検索</a></span><span> &gt; </span><span><a title=\"シラバス検索結果\" href=\"/Syllabus/App/Search/SearchList.aspx\">シラバス検索結果</a></span><span> &gt; </span><span>授業詳細</span><a id=\"bfFooter_smp_SkipLink\"></a></span></TD><TD align=\"right\"><a href=\"#page_top\">↑ページの先頭へ戻る
</a><IMG height=\"1\" alt=\"\" src=\"common_images/spacer.gif\" width=\"40\"></TD></TR></TABLE></TD></tr><tr><TD valign=\"top\" align=\"left\" background=\"common_images/foota_left.gif\">&nbsp;</TD><TD valign=\"top\" align=\"right\" background=\"common_images/foota_left.gif\"><IMG height=\"120\" alt=\"北海道大学タイトル\" src=\"common_images/hu_foota_right.jpg\" width=\"670\"></TD></tr></table></TD><!-- foota end--></TR></TBODY></TABLE></form></body></HTML>
EOF
        subject.get_subject_informations

        subject.subject_identifier.should eq("anatomy_histology")
        subject.subject_name.should eq("解剖学（組織学）")
        subject.subject_staff.should eq("岩永 敏彦")
        subject.subject_lct_cd.should eq("021689")
      end
    end

  end



  describe "validation:" do

    before(:all) do
      @term = Term.new
      @term.term_identifier = '1b'
      @term.set_term_name
      @term.term_timetable_img = "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x01,\x01,\x00\x00\xFF\xE1\x10ZExif\x00\x00MM\x00*\x00\x00\x00\b\x00\x02\x87i\x00\x04\x00\x00\x00\x01\x00\x00"
      @term.term_timetable_thumb = "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x01,\x01,\x00\x00\xFF\xE1\x10ZExif\x00\x00MM\x00*\x00\x00\x00\b\x00\x02\x87i\x00\x04\x00\x00\x00\x01\x00\x00"
      @term.term_timetable_img_content_type = "image/jpeg"
      @term.save!

      subject = @term.subjects.new
      subject.subject_identifier = 'statistics'
      subject.subject_name = '統計学'
      subject.subject_staff = '後藤 允'
      subject.subject_lct_cd = '020648'
      subject.subject_syllabus_html = '<html></html>'
      subject.save!
    end

    before(:each) do
      @subject = @term.subjects.new
      @subject.subject_identifier = 'math_1'
      @subject.subject_name = '数学Ⅰ'
      @subject.subject_staff = '名前或蔵'
      @subject.subject_lct_cd = '021543'
      @subject.subject_syllabus_html = '<html></html>'
    end

    context "with valid information" do
      it "should be valid" do
        @subject.should be_valid
      end
    end

    context "without :term_identifier" do
      it "should not be valid" do
        @subject.term_identifier = nil
        @subject.should_not be_valid
      end
    end

    context ":term_identifier has invalid format" do
      it "should not be valid" do
        @subject.term_identifier = "1c"
        @subject.should_not be_valid
      end
    end

    context "without :subject_identifier" do
      it "should not be valid" do
        @subject.subject_identifier = nil
        @subject.should_not be_valid
      end
    end

    context ":subject_identifier is not unique" do
      it "should not be valid" do
        @subject.subject_identifier = "statistics"
        @subject.should_not be_valid
      end
    end

    context ":subject_identifier has invalid format" do
      it "should not be valid" do
        @subject.subject_identifier = "math_A"
        @subject.should_not be_valid
      end
    end

    context "without :subject_name" do
      it "should not be valid" do
        @subject.subject_name = nil
        @subject.should_not be_valid
      end
    end

    context ":subject_name is not unique" do
      it "should not be valid" do
        @subject.subject_name = "統計学"
        @subject.should_not be_valid
      end
    end

    context "without :subject_staff" do
      it "should not be valid" do
        @subject.subject_staff = nil
        @subject.should_not be_valid
      end
    end

    context ":subject_staff is not unique" do
      it "should be valid" do
        @subject.subject_staff = "後藤 允"
        @subject.should be_valid
      end
    end

    context "without :subject_lct_cd" do
      it "should be valid" do
        @subject.subject_lct_cd = nil
        @subject.should be_valid
      end
    end

    context ":subject_lct_cd is not unique" do
      it "should not be valid" do
        @subject.subject_lct_cd = "020648"
        @subject.should_not be_valid
      end
    end

    context "withou :subject_syllabus_html" do
      it "should not be valid" do
        @subject.subject_syllabus_html = nil
        @subject.should_not be_valid
      end
    end

  end

end
