class CustomNumericalityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.each do |v|
      if (attribute == :tag_ids && Tag.ids.exclude?(v.to_i)) || (attribute == :category_ids && Category.ids.exclude?(v.to_i))
        record.errors.add attribute, (options[:message] || 'は選択肢の中から選んで下さい')
        break
      end
    end
  end
end
