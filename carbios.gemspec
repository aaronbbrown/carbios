# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "carbios/version"

Gem::Specification.new do |s|
  s.name        = "carbios"
  s.version     = Carbios::VERSION
  s.authors     = ["Aaron Brown"]
  s.email       = ["abrown@ideeli.com"]
  s.homepage    = "https://github.com/ideeli/carbios"
  s.summary     = %q{Nagios perfdata to Graphite/Carbon connector}
  s.description = %q{Nagios perfdata to Graphite/Carbon connector}

  s.rubyforge_project = "carbios"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "graphite"
  s.rubygems_version = '1.3.5'
end
