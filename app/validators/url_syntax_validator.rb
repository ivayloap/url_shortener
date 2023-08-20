class UrlSyntaxValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    uri = URI.parse(value)
    raise_error(record, value) unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    raise_error(record, value)
  end

  private

  def raise_error(record, value)
    raise Errors::InvalidUrlError.new("The provided URI is not correct -> '#{value}'")
  end
end
