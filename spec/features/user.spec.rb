require 'rails_helper'

RSpec.feature "ユーザー毎のタスク管理機能", type: :feature do
  before do
    FactoryBot.create(:user)
  end 
  scenario "ユーザー登録のテスト" do 
    visit new_user_path
    fill_in 'user_name', with: 'jerry garcia'
    fill_in 'user_email', with: 'test@sg.com'
    fill_in 'user_password', with: '111111'
    fill_in 'user_password_confirmation', with: '111111'
    
    click_on "アカウント作成"
    expect(page).to have_content 'タスク一覧'
    
  end
  scenario "login機能,ユーザー詳細ページ遷移,Logout機能テスト" do 
    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    expect(page).to have_content 'タスク一覧'
    click_on 'My page'
    expect(page).to have_content 'ジミヘンドリクス'
    click_on 'タスク一覧'
    expect(page).to have_content 'タスク一覧'
    click_on 'Logout'
    expect(page).to have_content 'ログアウトしました'
  end
end