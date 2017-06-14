module Contactually
  class Interactions
    def initialize(master)
      @master = master
    end

    def create(params = {})
      hash = @master.call('interactions.json', :post, params)
      Contactually::Utils.build_interaction(hash)
    end

    def destroy(id, params = {})
      @master.call("interactions/#{id}.json", :delete, params)
    end

    def show(id, params = {})
      hash = @master.call("interactions/#{id}.json", :get, params)
      Contactually::Utils.build_interaction(hash)
    end

    def update(id, params = {})
      hash = @master.call("interactions/#{id}.json", :put, params)
      Contactually::Utils.build_interaction(hash)
    end
  end
end
