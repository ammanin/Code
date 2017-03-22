=begin
Project: Wikibot 
Version: v1.1
Author: Ammani nair
Date: 3/20/2017
=end

# Calling the databases and addon's required

require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'rake'
require 'twilio-ruby'

# set :database_file, "D:/drive/Wikibot/Code/config/database.yml"

# enable sessions for this project
enable :sessions
client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
POS_RESPONSES  = ["true","okay", "ok","yes", "indeed", "yup","yeah", "ya", "correct", "sure"]
NEG_RESPONSES = ["no","false", "nope","wrong", "incorrect", "nada"]
POS_EXCLAMATIONS = ["Excellent", "Awesome", "Great", "Cool"]
GREETINGS = ["Hi","Yo", "Hey","Howdy", "Hello"]

get "/" do
end
# For troubleshooting purposes
=begin
get "/send_sms" do
	client.account.messages.create(
	:from => ENV["TWILIO_NUMBER"],
	:to => "+14129548714", # end user
	:body => "Thanks! You've signed up"
	)
	"Send Message"
end
=end

get '/incoming_sms' do
	
  #session["last_context"] ||= nil
  
  sender = params[:From] || ""
  body = params[:Body] || ""
  body = body.downcase.strip
  
 if body != ""
	if session["last_context"] = nil  
		message1 = get_about_message
		message2 = "First, what should I call you?"
		session["last_context"] = "signup_u"
	elsif session["last_context"] == "signup_u"
		name = body
		message = "Thanks! Secondly, what's your zipcode?"
		session["last_context"] = "signup_z"
	elsif session["last_context"] == "signup_z"
		zip = body.to_int
		Message = " Nice to meet ya " + name + "🙂. It looks like you're a New York state resident and a Brooklyn voter. Is that correct?"
		session["last_context"] == "signup_re"
	elsif session["last_context"] == "signup_re" 
		if POS_RESPONSES.include? body.to_s
			session["last_context"] = POS_EXCLAM1ATIONS + ", we should be good to go. A warm welcome from Wikibot!"
			# Add name to database
			# Add zip to database
			session["last_context"] = "member"
		elsif NEG_RESPONSES.include? body.to_s
			message = "No worries! Just let me know the corrected name, zipcode or both in seperate messsages. "
			session["last_context"] = "signup_redo"
		end
	elsif session["last_context"] == "signup_redo"
		if body == body.to_int && body.length == 5 # check if it's a zip or a name
			zip = body
		else
			name = body
		end
		message = POS_EXCLAMATIONS + " ,you're" + name + " from " + zip + " area. Correct?"
		session["last_context"] = "signup_re"
 	elsif session["last_context"] == "mission"
		if POS_RESPONSES.include? body.to_s
			message = "👏 Fantastic 👏 Here's her office's number: 212-689-8368."
		end
	elsif session["last_context"] == "report"
		if POS_RESPONSES.include? body.to_s
		message = "Excellent 🏅 Great work!" 
		end
	end
	
else
	message = " Sorry, the words melted away. Could you repeat that?"
end

 twiml = Twilio::TwiML::Response.new do |r|
   r.Message message
end
 twiml.text
	
end


get "/reset" do	
	session["last_context"] = nil
end


private 

def get_signup_message
  GREETINGS.sample + ", thanks for signing upaa"
end