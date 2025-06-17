class WordParser
  def self.parse(str)
    new(str).words
  end

  def initialize(str)
    @input = str
  end

  def words
    case @input
    when /^[A-Z0-9_]+$/ # MACRO_CASE
      @input.split("_").map(&:downcase)
    when /_/ # snake_case
      @input.split("_")
    when /^[A-Z]/ # UpperCamelCase
      split_camel_case
    else # lowerCamelCase
      split_camel_case
    end
  end

  private

    def split_camel_case
      @input.gsub(/([a-z0-9])([A-Z])/, '\1 \2').split.map(&:downcase)
    end
end
