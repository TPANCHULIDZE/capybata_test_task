## instalation
  for instalation you have to have gems: `webdrivers, selenium-webdriver, capybara, rspec, dotenv, nokogiri`.

## ALERT
  Before you run any command, we use **ENV** varibales, because of this you have to create .env file in root and fill it with:            ```EMAIL=your_stackOwerflow_email```         
  ```PASSWORD=your_stackOwerflow_password```            
  otherwise any command will be failed.        

## to access StackOwerflow methods
  you have to run command from root ```ruby stackOwerflow.rb **method name here**```
  This class have public methods: ```login!, logout, find_tags, find_users, open_chat_with_active_users, open_chat_in_active_rooms```

## run test
  To run test you have to run command ```rspec spec/stackOwerflow_spec.rb```
  If in testing process you see **Human verification** you have 30 second to fill that on your own, otherwise test failed.

## Results
  To see results of methods check **results.txt** file