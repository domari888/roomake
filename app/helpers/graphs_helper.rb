module GraphsHelper
  def result_label(table)
    table == "likes_average" ? "平均" : "合計"
  end

  def suffix_name(table)
    table == "likes_count" || table == "likes_average" ? "いいね !" : "件"
  end
end
