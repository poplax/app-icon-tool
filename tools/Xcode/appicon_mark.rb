#!/usr/bin/env ruby

require 'rubygems'
require 'commander'
require_relative 'proj_config'

# App Icon setup.
class AppIconMark
  include Commander::Methods
  include XcodeprojConfig

  # Run script.
  def run
    program :name, 'Project of AppIcon info setup.'
    program :version, '0.0.1'
    program :description, 'Xcodeproj configuration.'

    command :install do |c|
      c.syntax      = "#{__FILE__} install [options]"
      c.summary     = 'Configuration the xcodeproj with AppIcon Mark.'
      c.description = 'AppIcon mark tool of xcodeproj setup.'
      c.example 'example', "#{__FILE__} install --project ProjectDemo[PATH] --target TargetName"
      c.option '--project STRING', 'The project path of \'*.xcodeproj\'.'
      c.option '--target STRING', 'The target name of project.'
      c.action do |args, options|

        if options.project && options.target
          project_name = options.project
          target_name  = options.target

          config_setup(project_name, target_name)
        end
      end
    end

    command :uninstall do |c|
      c.syntax      = "#{__FILE__} uninstall [options]"
      c.summary     = 'Remove AppIcon Mark from your project.'
      c.description = 'AppIcon mark tool cleanup.'
      c.example 'example', "#{__FILE__} uninstall --project ProjectDemo[PATH]"
      c.option '--project STRING', 'The project path of \'*.xcodeproj\'.'
      c.option '--target STRING', 'The target name of project.'
      c.action do |args, options|

        if options.project
          project_name = options.project
          target_name ||= options.target

          config_remove(project_name, target_name)
        end
      end
    end

    run!
  end
end

AppIconMark.new.run if $0 == __FILE__
