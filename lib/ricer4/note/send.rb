module Ricer4::Plugins::Note
  class Send < Ricer4::Plugin

    trigger_is "note.send"

    has_usage '<user> <message>'

    def execute(receiver, text)
      
      return rply :err_send_self if sender == receiver 
      
      note = Message.create!({
        sender: sender,
        receiver: receiver,
        message: text,
      })
      
      if receiver.online?
        receiver.send_message(note.display_show_item, self)
        rply :msg_instant
      else
        rply :msg_stored
      end
      
    end

  end
end
