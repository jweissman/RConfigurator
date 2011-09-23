module RConfigurator
  
  #
  #   takes a string_with_underbars and ConvertsToCamelCase
  #
  module StringUtilities
    def convert_string_to_camel_case(string)
      new_string = string.gsub(/^[a-z]|_+[a-z]/) { |a| a.upcase }
      new_string.gsub!('_', '')
      new_string
    end
  end
end