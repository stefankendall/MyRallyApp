desc 'Run the tests'

task :test => [:unit]

task :unit do
  passed = system('xctool clean -workspace MyRallyApp.xcworkspace -scheme MyRallyAppTests build test')
  fail 'Unit tests failed' unless passed
end

task :default => :test
