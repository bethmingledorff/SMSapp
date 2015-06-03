require 'rubygems'
require 'twilio-ruby'
require 'yaml'

@from_number= '+17732450640' #replace with phone number provided by twilio
@to_number= '17732515960'  #replace with actual phone number
@body = "Test message from simple-sms.rb" #replace with your text message

conf=YAML.load_file('twilio_conf.yml')
@account_sid = conf['account_sid']
@auth_token = conf['auth_token']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(@account_sid, @auth_token)

@account = @client.account
@message = @account.sms.messages.create({:from => @from_number, :to => @to_number, :body => @body})
puts @message
