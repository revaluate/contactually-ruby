module Contactually
  class Buckets
    def initialize(master)
      @master = master
    end

    def create(params = {})
      hash = @master.call('buckets.json', :post, params)
      Contactually::Utils.build_bucket(hash)
    end

    def destroy(id, params = {})
      @master.call("buckets/#{id}.json", :delete, {})
    end

    def destroy_multiple(params = {})
      @master.call('buckets.json', :delete, params)
    end

    def show(id, params = {})
      hash = @master.call("buckets/#{id}.json", :get, params)
      Contactually::Utils.build_bucket(hash)
    end

    def update(id, params = {})
      hash = @master.call("buckets/#{id}.json", :put, params)
      Contactually::Utils.build_bucket(hash)
    end

    def index(params = {})
      hash = @master.call('buckets.json', :get, params)
      Contactually::Utils.buckets_hash_to_objects(hash)
    end

    def contacts(id, params = {})
      hash = @master.call("buckets/#{id}/contacts.json", :get, params)
      Contactually::Utils.contacts_hash_to_objects(hash)
    end

    def add_contact(id, params = {})
      hash = @master.call("buckets/#{id}/contacts.json", :post, params)
      Contactually::Utils.contacts_hash_to_objects(hash)
    end

    def remove_contact(id, params = {})
      hash = @master.call("buckets/#{id}/contacts.json", :delete, params)
      Contactually::Utils.contacts_hash_to_objects(hash)
    end

    def remove_contact_from_all_buckets(id, params = {})
      contact = @master.contacts.show(id)
      contact.buckets.collect(&:id).each do |b|
        remove_contact(b, params.deep_merge(data: { id: contact.id }))
      end
    end

    def search(search_term, params = {})
      # contacts/search.json isn't in the API docs anymore - changing this to use 'q' as the documented search
      # https://developers.contactually.com/docs/v2/#contacts-list-get
      search_merge = { q: search_term }.merge(params)
      hash = @master.call('buckets.json', :get, search_merge)
      Contactually::Utils.buckets_hash_to_objects(hash)
    end

    def count(params = { limit: 1 })
      @master.call('buckets.json', :get, params)["meta"]["total"]
    end
  end
end
