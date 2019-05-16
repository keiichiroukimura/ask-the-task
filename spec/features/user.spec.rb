require 'rails_helper'

RSpec.feature "ユーザー毎のタスク管理機能", type: :feature do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
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
  scenario "管理画面からユーザーを新規作成" do
  visit new_session_path
  fill_in 'session_email', with: 'crybaby@email.com'
  fill_in 'session_password', with: '111111'
  click_on "Log in"
  click_on "管理画面"
  click_on "ユーザー登録"
  fill_in 'user_name', with: 'スティーブクロッパー'
  fill_in 'user_email', with: 'steave@e.com'
  fill_in 'user_password', with: '111111'
  fill_in 'user_password_confirmation', with: '111111'
  click_on "登録する"
  expect(page).to have_content 'スティーブクロッパー'
  end
  scenario "管理画面からユーザーを編集" do
    visit new_session_path
    fill_in 'session_email', with: 'crybaby@email.com'
    fill_in 'session_password', with: '111111'
    click_on "Log in"
    click_on "管理画面"
    all('table tr')[1].click_link '編集'
    fill_in 'user_name', with: 'ドナルドダックダン'
    fill_in 'user_email', with: 'steave@e.com'
    fill_in 'user_password', with: '111111'
    fill_in 'user_password_confirmation', with: '111111'
    click_on "登録する"
    expect(page).to have_content 'ドナルドダックダン'
    end
    scenario "管理画面からユーザーを削除" do
      visit new_session_path
      fill_in 'session_email', with: 'crybaby@email.com'
      fill_in 'session_password', with: '111111'
      click_on "Log in"
      click_on "管理画面"
      all('table tr')[1].click_link '削除'
      expect(page).to have_content '「ジミヘンドリクス」を削除しました。'
      end
      scenario "管理画面以外のログイン制御" do
        visit new_session_path
        fill_in 'session_email', with: 'poul@email.com'
        fill_in 'session_password', with: '222222'
        click_on "Log in"
        expect(page).not_to have_content '管理画面'
        save_and_open_page
      end
end