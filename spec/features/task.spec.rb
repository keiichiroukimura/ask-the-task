require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    user_a = FactoryBot.create(:user)
    FactoryBot.create(:task, user: user_a)
    FactoryBot.create(:second_task, user: user_a)
  end
  scenario "タスク一覧のテスト" do
    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    expect(page).to have_content 'タスク一覧'
  end
  scenario "タスク作成のテスト" do

    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on "タスクを登録する"
    fill_in 'new_title', with: 'test_task_01'
    fill_in 'new_content', with: 'testtesttest'
    click_on '登録する'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク詳細のテスト" do
    # Task.create!(user_id: '1', title: 'test_task_01', content: 'testtesttest',deadline: Date.today, priority: '高', status: '未着手')
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    all('table tr')[1].click_link '詳細'
    expect(page).to have_content 'test_task_02'
    expect(page).to have_content 'samplesample'
    expect(page).to have_content  Date.today + 1
    expect(page).to have_content '中'
    expect(page).to have_content '未着手'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # backgroundに必要なタスクデータの作成処理が書かれているので、ここで書く必要がない
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    # タスクが作成日時の降順に並んでいるかのテスト
    #'終了期限でソートする'ボタンもテーブルの中に入っているので、'test_task_02'はテーブルの２番目の値になる。
    # click_on "タスクを登録する"
    # fill_in 'new_title', with: 'test_task_01'
    # fill_in 'new_content', with: 'testtesttest'
    # click_on '登録する'
    value = all("table tr")[1]
    expect(value).to have_content 'test_task_02'
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
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on '締切期限'
    deadline = all("table tr")[2]
    expect(deadline).to have_content "test_task_02"
  end
  scenario "タスク名検索機能テスト" do
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    fill_in 'title', with: 'test_task_01'
    click_on '検索'
    expect(page).to have_content "test_task"
    expect(all("table tr")[1]).to_not have_content "test_task_02"
    # expect(all("table tr")[2]).to have_content "test_task"
  end
  scenario "状態検索機能テスト" do
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    select '着手中', from: 'status'
    click_on '検索'
    expect(all("table tr")[1]).to_not have_content "未着手"
    # expect(all("table tr")[2]).to have_content "着手中"
  end
  scenario "タスク名,状態検索機能テスト" do
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    fill_in 'title' , with: 'test_task_01'
    select '着手中', from: 'status'
    click_on '検索'
    expect(all("table tr")[1]).to_not have_content "未着手","test_task_02"
    expect(all("table tr")[2]).to_not have_content "未着手","test_task_02"
    # expect(all("table tr")[2]).to have_content "着手中","AAA"
  end
  scenario "優先順位に並んでいるかのテスト" do
    visit new_session_path
    
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on '優先度'
    expect(all("table tr")[1]).to have_content "高"
    expect(all("table tr")[2]).to have_content "中"
  end
  scenario "管理者ラベル作成" do
    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on "管理画面"
    click_on "ラベル作成"
    fill_in 'label_content', with: 'イベント'
    click_on "登録する"
    expect(page).to have_content "イベント"
  end
  scenario "タスクラベル添付機能テスト" do
    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on "管理画面"
    click_on "ラベル作成"
    fill_in 'label_content', with: 'イベント'

    click_on "登録する"
    click_on "My page"
    click_on "タスク一覧"
    click_on "タスクを登録する"
    fill_in 'new_title', with: 'test_task_01'
    fill_in 'new_content', with: 'testtesttest'
    check 'task[label_ids][]'
    click_on '登録する'
    save_and_open_page
    expect(all("table tr")[1]).to have_content "イベント"
    # expect(page).to have_content 'testtesttest'
    # visit new_session_path
    # fill_in 'session_email', with: 'crybaby@email.com'
    # fill_in 'session_password', with: '111111'
    # click_on "Log in"
    # click_on "管理画面"
    # click_on "ラベル作成"
    # fill_in 'label_content', with: 'イベント'
    # click_on "登録する"
    # expect(page).to have_content "イベント"
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
