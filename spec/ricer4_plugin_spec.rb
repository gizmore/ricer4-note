require 'spec_helper'

describe Ricer4::Plugins::Note do
  
  # LOAD
  bot = Ricer4::Bot.new("ricer4.spec.conf.yml")
  bot.db_connect
  ActiveRecord::Magic::Update.install
  ActiveRecord::Magic::Update.run
  bot.load_plugins
  ActiveRecord::Magic::Update.run
  bot.save_all_offline
  
  NOTES = Ricer4::Plugins::Note::Message
  USERS = Ricer4::User
  SERVERS = Ricer4::Server
  CHANNELS = Ricer4::Channel

  it("truncates tables") do
    USERS.destroy_all
    expect(NOTES.count).to eq(0)
  end


  it("can create alice and bob") do
    expect(bot.users.online.count).to eq(0)
    bot.exec_line_as('Ugah', 'help')
    expect(bot.users.online.count).to eq(1)
    bot.exec_line_as('Gunda', 'help')
    expect(bot.users.online.count).to eq(2)
  end
  
  
  it("detects online instant delivery") do
    expect(bot.exec_line_as_for('Ugah', 'Note/Send', 'Gunda hello')).to eq('msg_instant')
  end

  it("can make a user go offline") do
    expect(bot.users.online.count).to eq(2)
    bot.exec_line_as('Gunda', 'xout')
    expect(bot.users.online.count).to eq(1)
  end
  
  it("can send notes") do
    expect(bot.exec_line_as_for('Ugah', 'Note/Send', 'Gunda i love you')).to eq('msg_stored')
    
    bot.exec_line_as('Gunda', 'help')
    expect(bot.users.online.count).to eq(2)
    expect(bot.exec_line_as_for('Gunda', 'Note/Inbox', '')).to include(",\"items\":2,")
  end
  
end
