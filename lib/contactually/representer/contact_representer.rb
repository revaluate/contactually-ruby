module Contactually
  class Contact < OpenStruct
  end

  module Representer
    class ContactRepresenter < Roar::Decorator
      include Roar::Representer::JSON
      property :id
      property :user_id
      property :first_name
      property :last_name
      property :full_name
      property :initials
      property :title
      property :company
      property :email
      property :avatar
      property :avatar_url
      property :visible
      property :twitter
      property :facebook_url
      property :linkedin_url
      property :first_contacted
      property :created_at
      property :updated_at
      property :hits
      property :team_parent_id
      property :snoozed_at
      property :snooze_days
      property :email_addresses
      property :tags
      property :contact_status
      property :phone_numbers
      property :addresses
      property :social_media_profiles
      property :websites
      property :custom_fields
      property :sent
      property :received
      property :link
      property :content
      property :meta
      collection :groupings, extend: GroupingRepresenter, class: Grouping
      nested :extra_data do
        property :last_contacted
        property :muted_at
        property :relationship_status
        property :team_last_contacted
        property :team_last_contacted_by
        property :last_bucketed_at
        property :user_last_contacted_at
        collection :buckets, extend: BucketRepresenter, class: Bucket
      end
    end
  end
end
