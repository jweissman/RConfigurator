# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "configurator/version"
require "configurator/utilities"

Gem::Specification.new do |s|
  s.name        = "configurator"
  s.version     = Configurator::VERSION
  s.authors     = ["Joseph Weissman"]
  s.email       = ["jweissman1986@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Configurator "hydrates" your Ruby application's module constants by walking
  through a yaml file}
  s.description = %q{Got constants strewn throughout your project? 
  You can use Configurator to aggregate their definitions into one place.}

  s.rubyforge_project = "configurator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
 # s.add_runtime_dependency "yaml"
end
