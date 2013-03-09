
require 'rake'
require 'digest/sha1'

EXCLUDES = %w(Rakefile README.md)
PREFIX = File.join(ENV['HOME'], 'Temp', 'dotfiles')

desc <<-EOS
    Installs dotfiles
EOS
task :install do
    (Dir['src/**'] - EXCLUDES).each do |path|
        src = File.join(Dir.pwd, path)
        dest = File.join(PREFIX, ".#{File.basename(path)}")

        if File.directory?(path)
            dest = File.join(PREFIX, File.basename(path)) if path =~ /\/bin$/
        end

        if File.directory?(dest)
            system %Q{rm -fr "#{dest}"}
        else
            system %Q{rm -f "#{dest}"}
        end

        system %Q{ln -s "#{src}" "#{dest}"}
    end
end
