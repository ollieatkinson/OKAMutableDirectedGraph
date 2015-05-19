Pod::Spec.new do |s|

  s.name         = "OKAMutableDirectedGraph"
  s.version      = "1.0.0"
  s.summary      = "OKAMutableDirectedGraph is an implementation of a directed graph in Objective-C."

  s.description  = <<-DESC

                   OKAMutableDirectedGraph was developed originally for managing dependencies - but it can be used for path finding, sorting, garbage collection and much more.

                   DESC

  s.homepage     = "https://github.com/ollieatkinson/OKAMutableDirectedGraph"
  # s.screenshots  = "https://camo.githubusercontent.com/88bd201250faa960dfc79e27003f5e3e937746ae/687474703a2f2f616c6773342e63732e7072696e6365746f6e2e6564752f343264697265637465642f696d616765732f646967726170682e706e67"


  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Oliver Atkinson" => "oliveratkinson@me.com" }

  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/ollieatkinson/OKAMutableDirectedGraph.git", :tag => "1.0.0" }

  s.source_files  = "OKAMutableDirectedGraph"
  s.exclude_files = "Classes/Exclude"

  s.requires_arc = true

end
