module Contactually
  class Interaction < OpenStruct
  end

  class Participant < OpenStruct
  end

  module Representer
    class InteractionRepresenter < Roar::Decorator # https://developers.contactually.com/docs/v2/#interactions
      include Roar::Representer::JSON
      property :id
      property :created_at
      property :updated_at
      property :body
      property :initiated_by_contact
      property :subject
      property :timestamp
      property :type # email	facebook	other	in_person linked_in	mad_mimi	mail_chimp	phone sms	twitter	zapier
      collection :participants, class: Participant do # they call them contacts but they return different info... so we can't just do this as a contact collection
        property :contact_id
        property :handle
        nested :extra_data do
          property :first_name
          property :last_name
          property :avatar_url
        end
      end
      nested :extra_data do
        property :editable
        property :participant_count
        property :contact_id
      end
      property :contact, extend: ContactRepresenter, class: Contact
      property :meta
    end
  end
end
