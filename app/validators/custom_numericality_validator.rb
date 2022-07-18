class CustomNumericalityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.each do |v|
      if (attribute == :tag_ids && v.to_i > 12) || (attribute == :category_ids && v.to_i > 18)
        record.errors.add attribute, (options[:message] || '入力された値は存在しません')
      end
    end
  end
end
