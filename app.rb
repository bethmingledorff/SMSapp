require 'sinatra'
require 'twilio-ruby'

#set up sinatra
configure do
  set :send_sms_password, "interact2013"
  set :twilio_account_sid, ENV['ACCOUNT_SID']
  set :twilio_auth_token, ENV['AUTH_TOKEN']
  set :twilio_from_number, ENV['FROM_NUMBER']

end

  get "/" do
     erb :send_sms_form
  end

  post "/send_sms" do
    puts "post send_sms"
    # @message="password is incorrect.  SMS failed." if settings.send_sms_password != params["password"]
    @message = "Please enter a valid 10-digit phone number.  SMS failed." if params["phone_number"].nil? || params["phone_number"].empty?
    @message = "Please enter your message in the Message field.  SMS failed." if params["message"].nil? || params["message"].empty?
    #if there's no message then the password matches and we have all of the required info
    if @message.nil?
      puts "sending sms"
      client = Twilio::REST::Client.new(settings.twilio_account_sid, settings.twilio_auth_token)
      account = client.account
      @sms_reply = account.sms.messages.create({:from => settings.twilio_from_number, :to => params["phone_number"], :body => params["message"]})
      puts "got back this: #{@sms_reply.inspect}"
    end

    if @message #render the original form again, with error message
      erb :send_sms_form
    else #render the message that sms was sent
      erb :sms_sent
    end
  end
