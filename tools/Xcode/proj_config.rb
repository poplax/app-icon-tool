#!/usr/bin/env ruby
# Config xcproject
# By poplax
# Date: 2018-03-30

require 'xcodeproj'

# Module of config Xcode Project.
module XcodeprojConfig
  include Xcodeproj
  include Xcodeproj::Project::Object

  extend Xcodeproj::Project::ProjectHelper

  MARK_SCRIPT_NAME      = '[Tool] Version-IconMark'.freeze
  SCRIPT_DIR            = 'Script'.freeze
  APP_ICON_NAME_DEFAULT = 'AppIcon'.freeze
  APP_ICON_NAME         = 'AppIcon-Dev'.freeze
  APP_ICON_ASSET_KEY    = 'ASSETCATALOG_COMPILER_APPICON_NAME'.freeze

  attr_reader :project

  # setup Xcodeproj config file.
  def config_setup(project_path = 'ProjectPath', target_name = 'TargetName')

    validate_project?(project_path) || exit!
    needs_update = false

    @project = Xcodeproj::Project.open(project_path)
    project.targets.each do |target|

      next if target.name != target_name

      setup_configuration(target)
      add_script(target)

      needs_update = true
    end

    needs_update && project.save
  end

  # Xcodeproj config remove.
  def config_remove(project_path, target_name = nil)
    validate_project?(project_path) || exit!
    needs_update = false

    @project = Xcodeproj::Project.open(project_path)
    project.targets.each do |target|
      next if !target_name.nil? && target.name != target_name

      cleanup_configuration(target)
      remove_script(target)
      project.save

      needs_update = true
    end

    needs_update && project.save
  end

  private

  def create_phase
    shell_phase = project.new(PBXShellScriptBuildPhase)
    shell_phase.name = MARK_SCRIPT_NAME
    shell_phase
  end

  # Add script phases
  def add_script(target)

    target.build_phases.each do |bp|
      bp.remove_from_project if validate_build_phase?(bp)
    end

    shell_phase = create_phase
    target.build_phases.unshift(shell_phase)
    shell_phase.shell_script = "\"${PROJECT_DIR}/#{SCRIPT_DIR}/icon_mark\""
  end

  # Configuration Appicon setting
  def setup_configuration(target, configuration = 'Debug')

    target_configuration_list = target.build_configuration_list
    icon_name                 = target_configuration_list.get_setting(APP_ICON_ASSET_KEY)[configuration]

    return if icon_name == APP_ICON_NAME
    target_configuration_list[configuration].build_settings[APP_ICON_ASSET_KEY] = APP_ICON_NAME
  end

  # Remove script.
  def remove_script(target)

    target.build_phases.each do |b|
      b.remove_from_project if validate_build_phase?(b)
    end
  end

  # Cleanup configuration.
  def cleanup_configuration(target, configuration = 'Debug')

    target_configuration_list = target.build_configuration_list
    icon_name                 = target_configuration_list.get_setting(APP_ICON_ASSET_KEY)[configuration]

    return if icon_name == APP_ICON_NAME_DEFAULT
    target_configuration_list[configuration].build_settings[APP_ICON_ASSET_KEY] = APP_ICON_NAME_DEFAULT
  end


  # Helper

  def validate_project?(project_path)
    ret = true
    unless Dir.exist?(project_path)
      puts "#{project_path} not exist."
      ret = false
    end
    ret
  end

  def validate_build_phase?(phase)
    ret = false
    if phase.class == Xcodeproj::Project::Object::PBXShellScriptBuildPhase && phase.name == MARK_SCRIPT_NAME
      ret = true
    end
    ret
  end
end




