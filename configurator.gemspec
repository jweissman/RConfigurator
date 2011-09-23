# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'rconfigurator/version'
Gem::Specification.new do |s|
  s.name        = "rconfigurator"
  s.version     = RConfigurator::VERSION
  s.authors     = ["Joseph Weissman"]
  s.email       = ["jweissman1986@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{RConfigurator "hydrates" your Ruby application's module constants by walking
  through a yaml file}
  s.description = %q{Got constants strewn throughout your project? 
  You can use RConfigurator to aggregate their definitions into one place.}

  s.rubyforge_project = "rconfigurator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  # s.add_runtime_dependency "rspec"
end
