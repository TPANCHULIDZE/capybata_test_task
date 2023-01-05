require 'webdrivers'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'nokogiri'
require 'dotenv/load'

Capybara.run_server = false
Capybara.current_driver = :selenium_chrome
Capybara.app_host = 'https://stackoverflow.com'


class StackOwerflow
  include Capybara::DSL

  def initialize email = ENV['EMAIL'], password = ENV['PASSWORD']
    Capybara.reset_session!
    @email = email
    @password = password
  end

  def login!
    visit('/')
    click_on('Accept all cookies')
    sleep 1
    click_on('Log in')
    sleep 1
    fill_form
    human_verification
  end


  
  def find_tags
    login!
    click_on('Tags')
    write_info('#tags-browser','a.post-tag')
  end

  def find_users
    login!
    click_on('Users')
    sleep 1
    write_info('#user-browser', 'div.user-details/a')
  end

  def open_chat_with_active_users
    open_chat
    all('a').find { |i| i[:href] == 'https://chat.stackoverflow.com/users' }.click
    sleep 1
    write_info '#userlist', 'div/div/h3/a'
  end

  def open_chat_in_active_rooms 
    open_chat
    all('a').find { |i| i[:href] == 'https://chat.stackoverflow.com/rooms' }.click
    sleep 1
    write_info '#roomlist', 'div/div/h3/span'
  end

  def logout
    click_on(class: 's-topbar--item js-site-switcher-button js-gps-track')
    click_on('log out')
    click_on('Log out')
  end
  
  private

  def human_verification
    if page.has_content?('Human verification')
      sleep 30
      if page.has_content?('Password')
        fill_form
      end
    end
  end

  def fill_form
    within("form#login-form") do
      fill_in 'email', with: @email
      fill_in 'password', with: @password
    end
    sleep 1
    find_button(id: 'submit-button').click
    sleep 2
  end
  
  def open_chat
    login!
    click_on(class: 's-topbar--item js-site-switcher-button js-gps-track')
    click_on('a', class: 'js-gps-track', text: 'chat')
  end
  
  def write_info address = 'div', link_address = 'a'
    tags_html = page.find(address).native.attribute('outerHTML')
    results = Nokogiri::HTML(tags_html).css(link_address).map { |i| i.content }
    File.write('results.txt', results)
  end
end

stackoverflow = StackOwerflow.new

puts ARGV[0]

case ARGV[0]
when 'login!'
  stackoverflow.login!
when 'find_tags'
  stackoverflow.find_tags
when 'find_users'
  stackoverflow.find_users
when 'open_chat_with_active_users'
  stackoverflow.open_chat_with_active_users
when 'open_chat_in_active_rooms'
  stackoverflow.open_chat_in_active_rooms
else
  puts 'Some arguments are invalid please check README.md file'
end
