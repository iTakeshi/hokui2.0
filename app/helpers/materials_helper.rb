# coding: utf-8

module MaterialsHelper
  def get_exam_title(number)
    base_name = case ( number / 10 )
                when 1
                  '第1回'
                when 2
                  '第2回'
                when 3
                  '第3回'
                when 4
                  '第4回'
                when 5
                  '第5回'
                when 6
                  '第6回'
                when 10
                  '中間'
                when 11
                  '期末'
                end

    appending = case ( number % 10 )
                when 0
                  ''
                when 1
                  '追試'
                when 2
                  '追々試'
                when 3
                  '追々々試'
                end

    return base_name + appending
  end
end
