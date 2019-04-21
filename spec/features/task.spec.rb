require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  
  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest', )
    Task.create!(title: 'test_task_02', content: 'samplesample')

    visit tasks_path
    
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do

    visit new_task_path
    
    fill_in 'new_title', with: 'test_task_01'
    fill_in 'new_content', with: 'testtesttest'
    
    click_on 'Create Task'
    
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(id: '1', title: 'test_task_01', content: 'testtesttest', deadline: '4月30日', priority: '1', status: 'a')
    
    visit task_path(1)
    
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content '4月30日'
    expect(page).to have_content '1'
    expect(page).to have_content 'a'
  end
end
