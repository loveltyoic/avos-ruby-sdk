module AVOS
  class Query
    def initialize(klass_name)
      @klass_name = klass_name
    end

    def construct
      
    end

    def where(query)
      results =  JSON.parse(AVOS.client.get("/classes/#{@klass_name}", {where: query}).body)["results"]
      # if query.is_a? Hash
      #   results = JSON.parse(AVOS.client.get("/classes/#{klass_name}", {where: query}).body)["results"]
      # elsif query.is_a? String
      #   results = Query.new(query)
      # end
      results.map do |data|
        AVOS::Object.new(@klass_name, data, data["objectId"])
      end

    end

    def find(avos_id)
      data = JSON.parse(AVOS.client.get("/classes/#{@klass_name}/#{avos_id}").body).reject { |k, v| k == "updatedAt" }
      object = AVOS::Object.new(@klass_name, data, avos_id)
    end

    def count(where = {})
      query = { "count" => 1, "limit" => 0, "where" => where }
      res = AVOS.client.get("/classes/#{@klass_name}", query)
      JSON.parse(res.body)["count"]
    end

  end
end