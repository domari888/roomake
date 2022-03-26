class ImageLengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || 'は最大6枚まで選択できます') if value.length > 6
  end
end
