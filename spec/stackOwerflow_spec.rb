require_relative '../stackOwerflow'
require 'capybara/dsl'
require 'capybara'
require 'dotenv/load'

describe StackOwerflow do 
  include Capybara::DSL

  before(:each) do
    @valid_email = ENV['EMAIL']
    @valid_password = ENV['PASSWORD'] 
  end

  describe 'login!' do 
    it 'give valid email and password' do
      stackOwerflow = StackOwerflow.new(@valid_email, @valid_password)
      stackOwerflow.login!
      expect(page).to have_content 'Top Questions'
      expect(page).to have_css 'div.s-avatar'
      stackOwerflow.logout
    end
    
    it 'give invalid email and password' do
      stackOwerflow = StackOwerflow.new('example@gmail.com', 'password')
      stackOwerflow.login!
      expect(page).to have_content 'The email or password is incorrect.'  
      expect(page).not_to have_content 'Top Questions'
      expect(page).not_to have_css 'div.s-avatar'
    end
  end

  describe 'find tags' do 
    before(:each) do
      @stackOwerflow = StackOwerflow.new(@valid_email, @valid_password);
      @stackOwerflow.find_tags
      sleep 1
    end

    it 'find_tags goes tags page' do
      expect(page).to have_content 'Tags'
      expect(page).to have_css 'h1.fs-headline1', text: 'Tags'
      expect(page).to have_css 'div#tags_list'
      sleep 1
    end
  end

  describe 'find users' do
    before(:each) do
      @stackOwerflow = StackOwerflow.new(@valid_email, @valid_password);
      @stackOwerflow.find_users
      sleep 1
    end

    it 'find_users goes users page' do
      expect(page).to have_content 'Users'
      expect(page).to have_css 'h1.fs-headline1', text: 'Users'
      expect(page).to have_css 'div#user-browser'   
    end
  end

  describe 'open chat with active users' do
    before(:each) do
      @stackOwerflow = StackOwerflow.new(@valid_email, @valid_password);
      @stackOwerflow.open_chat_with_active_users
      sleep 1
    end

    it 'find online users' do
      expect(page).to have_content 'users who are online'  
      expect(page).to have_css 'li.youarehere'
    end
  end

  describe 'find online rooms' do
    before(:each) do
      @stackOwerflow = StackOwerflow.new(@valid_email, @valid_password);
      @stackOwerflow.open_chat_in_active_rooms
      sleep 1
    end

    it 'find online rooms' do
      expect(page).to have_content 'a list of all rooms, most populated rooms first'  
      expect(page).to have_css 'li.youarehere'
    end
  end

  describe 'logout' do
    before(:each) do
      @stackOwerflow = StackOwerflow.new(@valid_email, @valid_password);
      @stackOwerflow.login!
      @stackOwerflow.logout
      sleep 1
    end

    it 'log out user' do
      expect(page).to have_css 'a', text: 'Log in'
      expect(page).to have_css 'a', text: 'Sign up'    
    end
  end
end
