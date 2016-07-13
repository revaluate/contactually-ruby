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
      Contactually::Utils.build_bucket(hash);
    end

    def index(params = {})
      hash = @master.call('buckets.json', :get, params)
      Contactually::Utils.buckets_hash_to_objects(hash)
    end

    def contacts(id, params = {})
      hash = @master.call("buckets/#{id}/contacts.json", :get, params)
      Contactually::Utils.contacts_hash_to_objects(hash)
    end

    def search(params = {})
      hash = @master.call('buckets/search.json', :get, params)
      Contactually::Utils.buckets_hash_to_objects(hash)
    end

    def count(params = { limit: 1 })
      @master.call('buckets.json', :get, params)["meta"]["total"]
    end
  end
end
