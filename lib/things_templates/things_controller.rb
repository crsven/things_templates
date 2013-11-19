class ThingsTemplates::ThingsController
  class << self
    def add_item(item)
      command = [base_command, add_item_command(item), end_command].join("\n")
      system(command)
    end

    def add_project(project)
      unless project_exists?(project)
        command_list = [base_command, add_project_command(project), end_command]
        command = command_list.join("\n")
        system(command)
      end
    end

    def add_items_to_project(project, items, tags=nil)
      add_project(project) unless project_exists?(project)
      commands = [base_command]
      items.each do |item|
        commands << add_item_command(item, project, tags)
      end
      commands << end_command
      command = commands.join("\n")
      system(command)
    end

    private

    def project_exists?(project)
      command = """
        set foundProject to project \"#{project}\"\n
        if status of foundProject is completed then\n
          return false\n
        else\n
          return true\n
        end if\n
      """
      command_list = [base_command, command, end_command].join("\n")
      response = `#{command_list}`
      return false unless response.include?("true") || response.include?("Can't get project")
      true
    end

    def add_item_command(item, project=nil, tags=nil)
      base_add = "set newToDo to make new to do with properties {name:\"#{item}\" }"
      base_add += " at beginning of project \"#{project}\"" if project
      base_add += tags_command(tags) if tags
      base_add
    end

    def add_project_command(project)
      "set newProject to make new project with properties {name:\"#{project}\"}"
    end

    def base_command
      "osascript -e 'tell application \"Things\""
    end

    def end_command
      "end tell'"
    end

    def tags_command(tags)
      "\nset tag names of newToDo to \"#{tags.join(', ')}\""
    end
  end
end
