json.text @message.text
json.name @message.user.name
json.day  @message.created_at.strftime("%Y-%m-%d %H:%M:%S")
json.id   @message.id

