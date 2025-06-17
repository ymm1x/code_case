class CodeCase
  def self.run(input)
    new(input).print_all_cases
  end

  def initialize(input)
    @base_words = WordParser.parse(input)
  end

  def print_all_cases
    forms = {
      "Snake Case"      => method(:snake_case),
      "LowerCamel Case" => method(:lower_camel_case),
      "UpperCamel Case" => method(:upper_camel_case),
      "Macro Case"      => method(:macro_case),
    }

    [:singular, :plural].each do |form|
      forms.each_value do |method|
        puts method.call(form)
      end
    end
  end

  private

    def macro_case(form)
      transform(form).join("_").upcase
    end

    def snake_case(form)
      transform(form).join("_")
    end

    def upper_camel_case(form)
      transform(form).map(&:capitalize).join
    end

    def lower_camel_case(form)
      first, *rest = transform(form).map(&:capitalize)
      [first.downcase, *rest].join
    end

    def transform(form)
      case form
      when :singular
        singularize_last(@base_words)
      when :plural
        pluralize_last(@base_words)
      else
        raise ArgumentError, "unknown form: #{form}"
      end
    end

    def pluralize_last(words)
      *head, last = words
      head + [last.pluralize]
    end

    def singularize_last(words)
      *head, last = words
      head + [last.singularize]
    end
end
