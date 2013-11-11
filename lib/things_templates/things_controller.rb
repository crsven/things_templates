class ThingsController
  class << self
    def add_item(item)
      command = [base_command, add_item_command(item), end_command].join("\n")
      system(command)
    end

    def add_project(project, items)
      commands = [
        base_command,
        add_project_command(project),
      ]
      items.each do |item|
        commands << add_item_command(item, project)
      end
      commands << end_command
      command = commands.join("\n")
      p command
      system(command)
    end

    private

    def add_item_command(item, project=nil)
      base_add = "set newToDo to make new to do with properties {name:\"#{item}\" }"
      base_add += " at beginning of project \"#{project}\"" if project
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
  end
end
