require_relative 'task_manager'

def display_menu
  puts "1. Add Task"
  puts "2. Delete Task"
  puts "3. Edit Task"
  puts "4. List Tasks"
  puts "5. Filter Tasks"
  puts "6. Exit"
  print "Choose an option: "
end

def main
  task_manager = TaskManager.new

  loop do
    display_menu
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter task title: "
      title = gets.chomp
      print "Enter description: "
      description = gets.chomp
      print "Enter deadline (YYYY-MM-DD): "
      deadline = gets.chomp
      task_manager.add_task(title, description, deadline)
      puts "Task added!"
    when 2
      print "Enter task title to delete: "
      title = gets.chomp
      task_manager.delete_task(title)
      puts "Task deleted!"
    when 3
      print "Enter task title to edit: "
      title = gets.chomp
      print "New title (press Enter to skip): "
      new_title = gets.chomp
      new_title = nil if new_title.empty?
      print "New description (press Enter to skip): "
      new_description = gets.chomp
      new_description = nil if new_description.empty?
      print "New deadline (YYYY-MM-DD, press Enter to skip): "
      new_deadline = gets.chomp
      new_deadline = nil if new_deadline.empty?
      print "New status (done/not done, press Enter to skip): "
      new_status = gets.chomp
      new_status = nil if new_status.empty?
      task_manager.edit_task(title, new_title: new_title, new_description: new_description, new_deadline: new_deadline, new_status: new_status)
      puts "Task updated!"
    when 4
      puts "Listing all tasks:"
      task_manager.filter_tasks.each do |task|
        puts "Title: #{task.title}, Description: #{task.description}, Deadline: #{task.deadline}, Status: #{task.status}"
      end
    when 5
      print "Enter status to filter (done/not done, press Enter to skip): "
      status = gets.chomp
      status = nil if status.empty?
      print "Enter deadline to filter (YYYY-MM-DD, press Enter to skip): "
      deadline = gets.chomp
      deadline = nil if deadline.empty?
      tasks = task_manager.filter_tasks(status: status, deadline: deadline)
      puts "Filtered tasks:"
      tasks.each do |task|
        puts "Title: #{task.title}, Description: #{task.description}, Deadline: #{task.deadline}, Status: #{task.status}"
      end
    when 6
      puts "Exiting..."
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

main
