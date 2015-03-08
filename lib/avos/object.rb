module AVOS
  class Object
    attr_reader :klass_name
    attr_accessor :avos_id
    include AVOS::Hash

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

  end
end