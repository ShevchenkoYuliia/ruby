require 'json'
require 'date'

class Task
  attr_accessor :title, :description, :deadline, :status

  def initialize(title, description, deadline, status = 'not done')
    @title = title
    @description = description
    @deadline = Date.parse(deadline)
    @status = status
  end

  def to_hash
    {
      title: @title,
      description: @description,
      deadline: @deadline.to_s,
      status: @status
    }
  end

  def self.from_hash(hash)
    new(hash['title'], hash['description'], hash['deadline'], hash['status'])
  end
end

class TaskManager
  FILE_PATH = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def add_task(title, description, deadline)
    task = Task.new(title, description, deadline)
    @tasks << task
    save_tasks
  end

  def delete_task(title)
    @tasks.reject! { |task| task.title == title }
    save_tasks
  end

  def edit_task(title, new_title: nil, new_description: nil, new_deadline: nil, new_status: nil)
    task = @tasks.find { |t| t.title == title }
    if task
      task.title = new_title if new_title
      task.description = new_description if new_description
      task.deadline = Date.parse(new_deadline) if new_deadline
      task.status = new_status if new_status
      save_tasks
    else
      puts "Task not found"
    end
  end

  def filter_tasks(status: nil, deadline: nil)
    filtered_tasks = @tasks
    filtered_tasks = filtered_tasks.select { |task| task.status == status } if status
    filtered_tasks = filtered_tasks.select { |task| task.deadline <= Date.parse(deadline) } if deadline
    filtered_tasks
  end

  private

  def load_tasks
    return [] unless File.exist?(FILE_PATH)

    JSON.parse(File.read(FILE_PATH)).map { |task_hash| Task.from_hash(task_hash) }
  end

  def save_tasks
    File.write(FILE_PATH, JSON.pretty_generate(@tasks.map(&:to_hash)))
  end
end
