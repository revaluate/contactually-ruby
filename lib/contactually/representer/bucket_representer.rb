module Contactually
  class Bucket < OpenStruct
  end

  module Representer
    class BucketRepresenter < Roar::Decorator
      include Roar::Representer::JSON
      property :id
      property :name
      property :goal
      property :reminder_interval
      property :created_at
      property :updated_at
    end
  end
end
