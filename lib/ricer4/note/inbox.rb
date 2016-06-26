module Ricer4::Plugins::Note
  class Inbox < Ricer4::Plugin
    
    forces_authentication

    is_list_trigger "notes.inbox", :for => Ricer4::Plugins::Note::Message
    
    protected

    def visible_relation(relation)
      relation.inbox(user)
    end
    
  end
end
