name = 'ossec'

vms = %w(ossec_server ossec_client)

# Should not have to change anything below here!

require 'rake'
require 'cucumber/rake/task'

source_dir = File.dirname(__FILE__)
spec_fixtures_dir = File.join(File.dirname(__FILE__), 'spec/fixtures')
spec_fixtures_modules_dir = File.join(spec_fixtures_dir, 'modules')
vagrant_modules_dir = File.join(File.dirname(__FILE__), 'vagrant/modules')

task :default => [:unit]

desc 'Check puppet manifests for lint errors'
task :lint do
  system('puppet-lint --with-filename --no-80chars-check manifests | grep ERROR')
end

desc 'Run all unit tests'
task :unit do
  begin
    FileUtils::mkdir_p(spec_fixtures_modules_dir)
    target = File.join(spec_fixtures_modules_dir, name)
    File::exists?(target) || FileUtils::ln_s(source_dir, target)
    system("cd #{spec_fixtures_dir} && librarian-puppet install")
    files_to_run = FileList['spec/{classes,defines}/**/*_spec.rb'].map { |f| f.gsub(/"/, '\"').gsub(/'/, "\\\\'") }.join(' ')
    spec_command = "ruby -S rspec #{files_to_run} --color"
    raise("#{spec_command} failed") unless system(spec_command)
  ensure
    FileUtils::rm(target)
  end
end

desc 'Loads / refreshes this module and module dependencies in preparation for Vagrant provisioning'
task :vagrant_prep do
  target = File.join(vagrant_modules_dir, name)
  FileUtils::rm_rf(target)
  FileUtils::mkdir_p(target)
  FileUtils::cp_r("#{source_dir}/files", target) if File::exists?("#{source_dir}/files")
  FileUtils::cp_r("#{source_dir}/lib", target) if File::exists?("#{source_dir}/lib")
  FileUtils::cp_r("#{source_dir}/manifests", target) if File::exists?("#{source_dir}/manifests")
  FileUtils::cp_r("#{source_dir}/templates", target) if File::exists?("#{source_dir}/templates")
  system('cd vagrant && librarian-puppet install')
end

vms.each do |vm|
  Cucumber::Rake::Task.new "acceptance_#{vm}", "Run acceptance tests for the \"#{vm}\" VM only; assumes the VM is already running" do |task|
    task.cucumber_opts = "--guess --exclude resources --tags @#{vm}"
  end
end

desc 'Run all acceptance tests: Will load module dependencies, then start all VMs and execute tests against each'
task :acceptance do
  begin
    Rake::Task[:vagrant_prep].invoke
    vms.each do |vm|
      system("vagrant up #{vm}")
      raise "vagrant up #{vm} failed" if $? != 0
    end

    vms.each do |vm|
      Rake::Task["acceptance_#{vm}"].invoke
#      system("vagrant destroy -f #{vm}")
#      raise "vagrant destroy -f #{vm} failed" if $? != 0
    end
  ensure
    system('vagrant destroy -f')
  end
end
