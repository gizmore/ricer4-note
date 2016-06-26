module Ricer4::Plugins::Note
  class Sent < Ricer4::Plugin
    
    forces_authentication
    
    is_list_trigger "notes.outbox", :for => Ricer4::Plugins::Note::Message

    protected

    def visible_relation(relation)
      relation.outbox(user)
    end
    
  end
end
