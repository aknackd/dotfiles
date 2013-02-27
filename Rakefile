
require 'rake'
require 'digest/sha1'

EXCLUDES = %w(Rakefile README.md)

desc <<-EOS
    Install dotfiles.
EOS
task :install do
    install_scripts
    setup_vim

    # symlink ~/bin
    dirname = File.join(ENV['HOME'], 'bin')
    if File.directory?(dirname)
        system %Q{rm -fr "#{dirname}"}
    elsif File.symlink?(dirname)
        system %Q{rm -f "#{dirname}"}
    end
    system %Q{ln -s "#{Dir.pwd}/bin" "#{dirname}"}
end

desc <<-EOS
    Checks if two files are identical according to their SHA1 checksums.
EOS
def identical?(file1, file2)
    return Digest::SHA1.file(file1).hexdigest == Digest::SHA1.file(file2).hexdigest
end

desc <<-EOS
    Returns filepath relative to user's home directory given a filename.
    If provided filename is a symlink, the symlink's real path is returned.
EOS
def readlink(file)
    filename = file
    if File.symlink?(file)
        filename = File.readlink(file)
        filename = File.join(ENV['HOME'], filename) if ! filename.start_with?('/')
    end

    return filename
end

desc <<-EOS
    Installs scripts.
EOS
def install_scripts
    files = Dir['**'] - EXCLUDES - %w(bin vim)
    files.each do |our_file|
        if File.directory?(our_file)
            dir = our_file
            Dir.glob("#{dir}/**").each do |filename|
                if dir =~ /^(bash|git)$/
                    src = "#{Dir.pwd}/#{filename}"
                    dest = File.join(ENV['HOME'], ".#{filename.sub(/^(bash|git)\//, '')}")
                    # symlink if not identical
                    if File.exist?(dest) && ! identical?(src, readlink(dest))
                        system %Q{rm -f "#{dest}" && ln -s "#{src}" "#{dest}"}
                    end
                end
            end
        else
            src = "#{Dir.pwd}/#{our_file}"
            dest = File.join(ENV['HOME'], ".#{our_file}")
            # symlink if not identical
            if File.exist?(dest) && ! identical?(src, readlink(dest))
                system %Q{rm -f "#{dest}" && ln -s "#{src}" "#{dest}"}
            end
        end
    end
end

desc <<-EOS
    Sets up vim and its configs.
EOS
def setup_vim
    src = "#{Dir.pwd}/vim/vimrc"
    dest = File.join(ENV['HOME'], ".vimrc")
    if File.exist?(src) && File.exist?(readlink(dest)) && ! identical?(src, readlink(dest))
        #system %Q{rm -f "#{dest} && ln -s "#{src}" "#{dest}"}
    end
end