module ApacheCLI
  class Apache < Thor
    package_name 'Thorium | Apache'

    include Thor::Actions

    class_option :verbose, :type => :boolean, :default => 1
    class_option :sudo, :type => :boolean, :default => 1
    class_option :ctl_method, :enum => ['apachectl', 'apache2ctl', 'service'], :default => 'apachectl'

    desc "ctl [ARGS]", "Apache controller wrapper"
    long_desc <<-LONGDESC
      `start`     - Starts apache
      `stop`      - Stops apache
      `restart`   - Restarts apache
      `graceful`  - Restarts apache gracefully
      `status`    - Apache status
      > $ ctl restart
    LONGDESC
    def ctl(*args)
      command = "#{options[:ctl_method]} #{args * ' '}"
      command = 'sudo ' + command if options[:root] == 1
      run(command, {:verbose => options[:verbose], :capture => false})
    end

    no_commands {

    }
  end
end