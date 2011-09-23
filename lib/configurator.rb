require "rconfigurator/version"
require "rconfigurator/utilities"
# require "rconfigurator/configurator"


# make a 'binding' to the local scope visible
$__global_scope = binding()

module RConfigurator
  
  #
  #  Use this configure! method to both create a new configurator AND
  #  launch the configuration process in one go.
  #
  def self.configure!(name, file)
    configurator = Configurator.new(name, file)
    configurator.configure
  end
  
  #
  # "Hydrate" a Ruby application's module constants from a configuration .yml
  #
  class Configurator
    
    include StringUtilities
    
    #
    #  Configurator.new takes the name of the project and a configuration file
    #  It does not perform any configuration yet; you must also call configure 
    #  if RConfigurator is invoked this way.
    #
    def initialize(project_name, config_file, opts={})
      @project_name = project_name
      @config_file  = config_file
      @data = YAML::load(File.open(@config_file)).to_hash
    end

    #
    #  Kicks off our recursive enumeration of the configuration
    #  data and module constant generation business logic.
    #
    def configure(debug=false)
      parse_and_recursively_create_constants!(@data, [], debug)
    end

    #
    #   configure application based on an easily-managed .yml file -- use 'eval' 
    #   to generate constants based on the structure of the hash we get from the yaml.
    #   most of the business logic for recursively parsing a hash and creating module 
    #   constants basically just involves tracking module names properly.
    #
    def parse_and_recursively_create_constants!(hash, module_context = [], debug=false)
      hash.each do |key, value|
        if value.is_a? Hash
          module_name = convert_string_to_camel_case(key)
          context = module_context.dup << module_name
          parse_and_recursively_create_constants!(hash[key], context, debug)
        else
          value_is_a_module = false

          if value.is_a? String
            if value.include? "::"
              value_is_a_module = true
            else
              value = "\"#{value}\""          
            end
          end

          if value_is_a_module
            # explicitly build out this module (since it doesn't exist) so that we can talk about it
            expression = value.split('::').map { |module_name| "module #{module_name}; "}.join(' ')
            value.split('::').count.times { expression << "end; "}
            eval(expression, $__global_scope)
            puts(expression) if debug
          end

          # define the given constant
          depth = module_context.count
          expr = module_context.map { |module_name| "module #{module_name}; " }.join(" ")
          expr << "#{key.upcase} = #{value}; " 
          depth.times { expr << "end; "}
          expr = "module #{@project_name}; #{expr}; end"
          eval(expr, $__global_scope)
          puts(expr) if debug
        end
      end
    end
  end
end