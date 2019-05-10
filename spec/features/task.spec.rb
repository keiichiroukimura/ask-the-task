require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:forth_task)
    FactoryBot.create(:fifth_task)
  end
  scenario "タスク一覧のテスト" do

    visit tasks_path
    
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do

    visit new_task_path

    fill_in 'new_title', with: 'test_task_01'
    fill_in 'new_content', with: 'testtesttest'
    click_on '登録する'

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(id: '1', title: 'test_task_01', content: 'testtesttest',deadline: Date.today, priority: '高', status: '未着手')
    
    visit task_path(1)
  
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content Date.today
    expect(page).to have_content '高'
    expect(page).to have_content '未着手'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # backgroundに必要なタスクデータの作成処理が書かれているので、ここで書く必要がない
    visit tasks_path
    # タスクが作成日時の降順に並んでいるかのテスト
    #'終了期限でソートする'ボタンもテーブルの中に入っているので、'test_task_02'はテーブルの２番目の値になる。
    value = all("table tr")[1]
    expect(value).to have_content 'AAABBB'
    # what: これは配列の順番を見るために作ったコード
    # how； 配列で取得するためにviewからだったらall modelからならallやwhere
    # why: 順番を確かめるためには一つの変数で複数の値を順番通りもてる配列を使わなきゃいけないから
    # ts = Task.order(created_at: "DESC").map do |task|
    # task.title
    # end
    # ts = Task.order(created_at: "DESC").pluck(:content)
    # expect(all(".task-item__content").map(&:text)).to eq ts
    # expect(all(".task-item__title").map(&:text)).to eq ts
  end
  scenario "終了期限の降順に並び替えられたタスク一覧ページが出現するかのテスト" do
    
    visit tasks_path
    click_on '締切期限'
    
    deadline = all("table tr")[2]
    expect(deadline).to have_content "test_task_02"
  end
  scenario "タスク名検索機能テスト" do
    visit tasks_path

    fill_in 'title', with: 'test_task'

    click_on '検索'
    
    expect(page).to have_content "test_task"
    expect(all("table tr")[1]).to have_content "test_task"
    expect(all("table tr")[2]).to have_content "test_task"
  end
  scenario "状態検索機能テスト" do
    visit tasks_path

    select '着手中', from: 'status'
    click_on '検索'
    expect(all("table tr")[1]).to have_content "着手中"
    expect(all("table tr")[2]).to have_content "着手中"
  end
  scenario "タスク名,状態検索機能テスト" do
    visit tasks_path

    fill_in 'title' , with: 'AAA'
    select '着手中', from: 'status'
    click_on '検索'
    expect(all("table tr")[1]).to have_content "着手中","AAA"
    expect(all("table tr")[2]).to have_content "着手中","AAA"
  end
  scenario "優先順位に並んでいるかのテスト" do
    visit tasks_path
    click_on '優先度'
    save_and_open_page
    expect(all("table tr")[1]).to have_content "高"
    expect(all("table tr")[2]).to have_content "中"
    expect(all("table tr")[3]).to have_content "低"
  end
  scenario "ページネーション機能テスト" do
    visit tasks_path
    click_on '2'
    
    expect(all("table tr")[1]).to have_content "test_task_02"
    expect(all("table tr")[2]).to have_content "test_task_01"
  end
end
#"タスクが作成日時の降順に並んでいるかのテスト" 
# t = all(".task-item__title")¥
# t == [
#   {title: " "},
#   {title: "a"},
# ]
# t[0].title

# {title: " "}[:title]

# [0," hfejkwa", "ewa"] == {0: 0, 1: " hfejkwa", 2: "ewa" }
# [0," hfejkwa", "ewa"][1]
# {0: 0, 1: " hfejkwa", 2: "ewa" }[:1]

# class Array
#   def pluck(property)
#     self.map{ |val| val.property }
#   end
#   # def pluck(property)
#   #   self.map{ |val| val[:property] }
#   # end
# end
