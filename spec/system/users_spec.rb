require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system, js: true do
  before do
    @user = FactoryBot.build(:user)
  end

  before do
    driven_by(:selenium_chrome)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてhomeページに移動する' do
      # topページに移動する
      visit root_path
      # topページにsign upページへ遷移するボタンがあることを確認する
      expect(page).to have_content('sign up')
      # sign upページへ移動する
      click_on 'sign up'
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # sign upボタンを押すとユーザーモデルのカウントが1上がることを確認する
      click_button 'sign up'
      expect(page).to have_current_path(home_path)
      expect(User.count).to eq 1
      # 各ページへの遷移ボタンが表示されていることを確認
      expect(page).to have_content('menu')
      expect(page).to have_content('record')
      expect(page).to have_content('archive')
      expect(page).to have_content('how to')
      expect(page).to have_content('sign out')
    end
    it 'パスワード表示切り替えボタンが機能する' do
      # sign upページへ移動する
      visit new_user_registration_path
      # パスワード欄に仮の値を入力する
      fill_in 'Password', with: 'samplepass'
      # 初期状態では目を閉じている
      expect(find('#user_password')[:type]).to eq 'password'
      # まぶたをクリックすると開眼し、パスワードが表示
      page.execute_script("document.getElementById('toggle-password').click()")
      sleep 0.5
      expect(find('#user_password')[:type]).to eq 'text'
      # 目玉をクリックすると目が閉じ、パスワードが非表示に
      page.execute_script("document.getElementById('toggle-password').click()")
      sleep 0.5
      expect(find('#user_password')[:type]).to eq 'password'
    end
    it 'パスワード再入力欄でも表示切り替えボタンが機能する' do
      # sign upページへ移動する
      visit new_user_registration_path
      # パスワード欄に仮の値を入力する
      fill_in 'Password confirmation', with: 'samplepass'
      # 初期状態では目を閉じている
      expect(find('#user_password_confirmation')[:type]).to eq 'password'
      # まぶたをクリックすると開眼し、パスワードが表示
      page.execute_script("document.getElementById('toggle-password-confirmation').click()")
      sleep 0.5
      expect(find('#user_password_confirmation')[:type]).to eq 'text'
      # 目玉をクリックすると目が閉じ、パスワードが非表示に
      page.execute_script("document.getElementById('toggle-password-confirmation').click()")
      sleep 0.5
      expect(find('#user_password_confirmation')[:type]).to eq 'password'
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # topページに移動する
      visit root_path
      # topページにsign upページへ遷移するボタンがあることを確認する
      expect(page).to have_content('sign up')
      # sign upページへ移動する
      click_on 'sign up'
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # sign upボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      click_button 'sign up'
      expect(page).to have_current_path(new_user_registration_path)
      expect(User.count).to eq 0
    end
  end

end

RSpec.describe 'ログイン', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
  end

  before do
    driven_by(:selenium_chrome)
  end

  context 'ログインできるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # topページに移動する
      visit root_path
      # topページにlog inページへ遷移するボタンがあることを確認する
      expect(page).to have_content('log in')
      # log inページへ移動する
      click_on 'log in'
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # log inボタンを押す
      click_button 'log in'
      #find('input[name="commit"]').click
      # 各ページへの遷移ボタンが表示されていることを確認
      expect(page).to have_content('menu')
      expect(page).to have_content('record')
      expect(page).to have_content('archive')
      expect(page).to have_content('how to')
      expect(page).to have_content('sign out')
    end
    it 'パスワード表示切り替えボタンが機能する' do
      # log inページへ移動する
      visit new_user_session_path
      # パスワード欄に仮の値を入力する
      fill_in 'Password', with: 'samplepass'
      # 初期状態では目を閉じている
      expect(find('#user_password')[:type]).to eq 'password'
      # まぶたをクリックすると開眼し、パスワードが表示
      page.execute_script("document.getElementById('toggle-password').click()")
      sleep 0.5
      expect(find('#user_password')[:type]).to eq 'text'
      # 目玉をクリックすると目が閉じ、パスワードが非表示に
      page.execute_script("document.getElementById('toggle-password').click()")
      sleep 0.5
      expect(find('#user_password')[:type]).to eq 'password'
    end
  end

  context 'ログインできないとき' do
    it '誤った情報ではログインできず、ログイン画面に戻ってくる' do
      # topページに移動する
      visit root_path
      # topページにlog inページへ遷移するボタンがあることを確認する
      expect(page).to have_content('log in')
      # log inページへ移動する
      click_on 'log in'
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # log inボタンを押す
      click_button 'log in'
      # log inページに戻ることを確認
      expect(page).to have_current_path(new_user_session_path)
    end
  end

end
