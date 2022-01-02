module GraphsHelper
  def result_label(table)
    table == 'likes-average' ? '平均' : '合計'
  end

  def suffix_name(table)
    ['likes-count', 'likes-average'].include?(table) ? 'いいね !' : '件'
  end
end
