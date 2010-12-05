require 'bundler'
require "rake/rdoctask"

# Add the bundler tasks, this comes because I used `bundle gem`.
Bundler::GemHelper.install_tasks

# `gem this` tasks
# Generate documentation
Rake::RDocTask.new do |rd| 
 rd.rdoc_files.include("lib/**/*.rb")
 rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
 rm "#{spec.name}.gemspec"
end
