
# module ElasticSearch
  class Index

    class Error < RuntimeError; end

    attr_reader :name, :mapping

    def initialize(name, mapping)
      @name = name
      @mapping = mapping
      @settings = mapping.try(:settings) || {}
    end

    def create
      raise Error.new("already exists") if index.exists?
      options = { mappings: @mapping.mappings, settings: @settings }
      index.create(options) or raise Error.new(last_response.body)
    end

    def create_if_not_exists
      create unless index.exists?
    end

    def import_in_batches(scope)
      scope.find_in_batches { |group| import(group) }
    end

    def import(collection)
      index.bulk_store(collection.map{ |entity| presenter_for(entity) })
    end

    def remove(entity)
      index.remove(presenter_for(entity))
    end

    def store(item)
      index.store(presenter_for(item))
    end

    def destroy
      index.delete
    end

    def last_response
      index.response
    end

    private

    def index
      @index ||= Tire::Index.new(@name)
    end

    def presenter_for(entity)
      ModelPresenter.new(entity, @mapping)
    end

  end
# end
