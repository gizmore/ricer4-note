module Ricer4::Plugins::Note
  class Note < Ricer4::Plugin
    
    def plugin_init
      arm_subscribe("ricer/user/loaded") do |sender, user|
        deliver_messages(user) unless user.registered?
      end
      arm_subscribe("user/signed/in") do |sender, user|
        deliver_messages(user)
      end
    end

    private
    
    def unread(user)
      Ricer4::Plugins::Note::Message.uncached do
        Ricer4::Plugins::Note::Message.inbox(user).unread.count
      end
    end
    
    def deliver_messages(user)
      count = unread(user)
      user.send_message(t(:msg_new_notes, count: count)) if count > 0
    end

  end
end
