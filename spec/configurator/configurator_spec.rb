libs = %w[ lib/ lib/configurator ]
libs.each { |lib| $:.unshift lib unless $:.include? lib }

require 'configurator'

describe Configurator, "performs dynamic Ruby application initialization" do
  it "parses a yaml configuration file and generates module constants" do
    Configurator.configure! "Sample", "spec/resources/sample.yml"
    
    # values defined in config file
    Sample::KEY.should == 'value'
    Sample::NUMERIC_DATA.should == 3.221
    Sample::SampleModule::SOME_KEY.should == 'another value'    
  end
  
  it "constructs modules if passed as values" do    
    Sample::KEY_SHOULD_BE_MODULE.should be_a_kind_of(Module)
    Sample::KEY_SHOULD_BE_MODULE.should == I::Am::A::Module
  end
end