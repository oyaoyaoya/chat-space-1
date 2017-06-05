json.messages @messages.all do |message|
  json.id message.id
  json.text message.text
  json.created_at message.created_at.strftime("%Y-%m-%d %H:%M:%S")
  json.name message.user.name
end
