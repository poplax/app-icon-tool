#!/usr/bin/env ruby
# Config xcproject
# By poplax
# Date: 2018-03-30

require 'xcodeproj'

PROJECT_NAME     = 'WMFairyZoneSDK'.freeze
TARGET_NAME      = 'WMFairyZoneSDKDemo'.freeze
MARK_SCRIPT_NAME = '[Tool] Version IconMark'.freeze
SCRIPT_DIR       = 'Script'.freeze

project_path = "#{PROJECT_NAME}.xcodeproj"

!Dir.exist?(project_path) && exit!
project = Xcodeproj::Project.open(project_path)

project.targets.each do |target|

  # Tagget to be setup.
  next if target.name != TARGET_NAME
  first_phase = target.build_phases.first

  target.build_phases.delete_if {|e| e.class == Xcodeproj::Project::Object::PBXShellScriptBuildPhase && e.name == MARK_SCRIPT_NAME}

  shell_phase = target.new_shell_script_build_phase(MARK_SCRIPT_NAME)
  target.build_phases.unshift(shell_phase).uniq!

  shell_phase.shell_script = "\"${PROJECT_DIR}/#{SCRIPT_DIR}/icon_mark\""

  project.save
end

