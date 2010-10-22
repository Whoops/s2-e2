require 'rake'
require 'spec/rake/spectask'

task :default => [:run]

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*.rb']
end

desc "Run the example"
task :run do
  ruby "-I lib/ bin/bank.rb"
end