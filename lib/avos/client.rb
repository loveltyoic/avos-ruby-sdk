module AVOS
  HOST = "https://leancloud.cn"
  class Client
    def initialize
      @conn = Faraday.new(AVOS::HOST) do |faraday|
        faraday.request :url_encoded
        # faraday.response :logger, Logger.new(STDOUT), {:bodies => { :request => true }}
        faraday.adapter Faraday.default_adapter
      end
    end

    def request(method, url, body={}, header={})
      avos_header = { 
        "X-AVOSCloud-Application-Id" => AVOS.app_id,
        "X-AVOSCloud-Application-Key" => AVOS.app_key,
        "Content-Type" => "application/json"
      }      
      @conn.send(method, "/1.1#{url}", body, avos_header.merge(header))
    end

    [:get, :post, :delete, :put].each do |m|
      define_method m do |url, data = {}, header ={}|
        request(m, url, data, header)
      end
    end

  end

  class << self
    def client
      raise "Not initialized" unless @@client
      @@client
    end
  end
end