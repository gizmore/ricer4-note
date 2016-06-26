module Ricer4::Plugins::Note
  class Unread < Ricer4::Plugin
    
    trigger_is "notes.unread"

    forces_authentication
    
    has_usage
    def execute
      note = chronological_unread
      return rply :err_all_read if note.nil?
      user.send_message(note.display_show_item(0))
    end
    
    private

    def chronological_unread
      Ricer4::Plugins::Note::Message.uncached do
        Ricer4::Plugins::Note::Message.inbox(user).unread.order('created_at ASC').first
      end
    end
    
  end
end
