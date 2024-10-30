require 'rspec'
require_relative 'task_manager'

RSpec.describe TaskManager do
  let(:task_manager) { TaskManager.new }

  before do
    File.write(TaskManager::FILE_PATH, '[]')
  end

  it 'adds a task' do
    task_manager.add_task('Test Task', 'Description', '2024-12-31')
    expect(task_manager.send(:load_tasks).size).to eq(1)
  end

  it 'deletes a task' do
    task_manager.add_task('Test Task', 'Description', '2024-12-31')
    task_manager.delete_task('Test Task')
    expect(task_manager.send(:load_tasks)).to be_empty
  end

  it 'edits a task' do
    task_manager.add_task('Test Task', 'Description', '2024-12-31')
    task_manager.edit_task('Test Task', new_title: 'New Title', new_status: 'done')
    task = task_manager.send(:load_tasks).first
    expect(task.title).to eq('New Title')
    expect(task.status).to eq('done')
  end

  it 'filters tasks by status' do
    task_manager.add_task('Task 1', 'Description 1', '2024-12-31')
    task_manager.add_task('Task 2', 'Description 2', '2024-12-31')
    expect(task_manager.filter_tasks(status: 'done').size).to eq(0)
  end
end
