module AVOS
  class User
    include AVOS::Hash
    attr_accessor :avos_id
    def initialize(avos_id, session_token)
      @avos_id = avos_id
      @session_token = session_token
      @hash = {}
    end

    class << self
      def register(user_info)
        res = AVOS.client.post("/users", user_info.to_json)
        if res.status == 201
          info = JSON.parse(res.body)
          self.new(info["objectId"], info["sessionToken"])
        else
          nil
        end
      end

      def signin(user_info)
        res = AVOS.client.get("/login", user_info)
        if res.status == 200
          info = JSON.parse(res.body)
          user = self.new(info["objectId"], info["sessionToken"])
          user.hash.merge(JSON.parse(res.body))
          user
        else
          nil
        end
      end
    end
  end
end
