libs = %w[ lib/  ]
libs.each { |lib| $:.unshift lib unless $:.include? lib }

require 'rconfigurator'

describe RConfigurator, "performs dynamic Ruby application initialization" do
  it "parses a yaml configuration file and generates module constants" do
    # p RConfigurator.methods - Module.methods
    
    RConfigurator.configure!("ExampleModuleName", "spec/resources/sample.yml", false)
    
    # n.b., these values are defined in the config file at spec/resources/sample.yml
    ExampleModuleName::KEY.should == 'value'
  end
  
  
  it "should handle nested constants" do
    ExampleModuleName::SampleModule::SOME_KEY.should == 'another value'    
  end
  
  it "should construct numeric constants correctly" do
    ExampleModuleName::NUMERIC_DATA.should == 3.221
  end
  
  
  it "should handle lists as arrays" do
    ExampleModuleName::KEY_SHOULD_BE_ARRAY.should be_a_kind_of(Array)
    ExampleModuleName::KEY_SHOULD_BE_ARRAY.should == [1,2]
  end
  
  it "should explicitly construct modules if passed as values" do
    ExampleModuleName::KEY_SHOULD_BE_MODULE.should be_a_kind_of(Module)
    ExampleModuleName::KEY_SHOULD_BE_MODULE.should == I::Am::A::Module
  end
end