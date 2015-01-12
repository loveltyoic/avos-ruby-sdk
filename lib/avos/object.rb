require 'forwardable'

class Hash
  def to_avos_data
    self.reduce({}) do |h, (key, val)|
      if val.is_a? AVOS::File
        val.upload unless val.saved?
        h.merge({ key => {"__type" => "File", "id" => val.avos_id} })
      elsif val.is_a?(AVOS::Relation)
        h.merge({ key => val.data })
      else
        h.merge({ key => val })
      end
    end.to_json
  end
end

module AVOS
  class Object
    attr_reader :klass_name
    attr_accessor :hash, :avos_id
    extend Forwardable

    def_delegators :@hash, :[]=, :merge!, :[], :to_avos_data

    def initialize(klass_name, data = {}, avos_id = nil)
      @klass_name = klass_name
      @hash = data
      @avos_id = avos_id
    end

    def save
      if @avos_id
        update(@hash)
      else
        res = AVOS.client.post("/classes/#{@klass_name}", self.to_avos_data)
        @avos_id = JSON.parse(res.body)["objectId"]
        res.status == 201
      end
    end

    def update(data={})
      raise "not saved yet" unless @avos_id
      avos_data = data.to_avos_data
      res = AVOS.client.put("/classes/#{@klass_name}/#{@avos_id}", avos_data)
      res.status == 200
    end

    def delete
      AVOS.client.delete("/classes/#{@klass_name}/#{@avos_id}") if @avos_id
    end

    def saved?
      !self.avos_id.nil?
    end

    class << self
      def where(klass_name, query = {})
        JSON.parse(AVOS.client.get("/classes/#{klass_name}", query).body)["results"].map do |data|
          AVOS::Object.new(klass_name, data, data["objectId"])
        end
      end

      def find(klass_name, avos_id)
        data = JSON.parse(AVOS.client.get("/classes/#{klass_name}/#{avos_id}").body).reject { |k, v| k == "updatedAt" }
        object = AVOS::Object.new(klass_name, data, avos_id)
      end

      def count(klass_name)
        query = { "count" => 1, "limit" => 0 }
        res = AVOS.client.get("/classes/#{klass_name}", query)
        JSON.parse(res.body)["count"]
      end
    end

  end
end