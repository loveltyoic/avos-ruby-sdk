module AVOS
  class File < Object

    def initialize(path)
      @path = path
      super("File")
    end

    def upload(name = nil)
      data = ::File.read(@path)
      fname = name ? name : ::File.basename(@path) 
      res = AVOS.client.post("/files/#{fname}", data, {"Content-Type" => content_type})
      body = JSON.parse(res.body)
      self.merge!(body)
      @avos_id = body["objectId"]
      res.status == 201
    end

    private 
    def content_type
      extname = ::File.extname(@path).sub(".", "")

      if extname =~ /(jpe?g|png|gif)/
        type = "image/" + $1
      else
        type = "text/plain"
      end
    end

  end
end