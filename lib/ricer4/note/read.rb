module Ricer4::Plugins::Note
  class Read < Ricer4::Plugin
    
    forces_authentication

    is_show_trigger "note.read", :for => Ricer4::Plugins::Note::Message
    
    protected

    def visible_relation(relation)
      relation.inbox(user)
    end
    
  end
end
