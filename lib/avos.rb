require "avos/version"
require "httpclient"
require "faraday"
require "json"
require "active_support"

require "avos/client"
require "avos/init"
require "avos/object"
require "avos/file"
require "avos/relation"

# module AVOS
#   mattr_accessor :app_id, :app_key

#   class << self 
#     def configure
#       yield self
#     end
#   end

#   class Object < Hash
#     BASE_URL = HOST + "/1.1/classes"
#     @@httpclient = Faraday.
#     @@avos_header = { 
#       "X-AVOSCloud-Application-Id" => AVOS.app_id,
#       "X-AVOSCloud-Application-Key" => AVOS.app_key,
#       "Content-Type" => "application/json"
#     }

#     def initialize(name)
#       @name = name
#     end

#     def save
#       response = @@httpclient.post(BASE_URL+"/#{@name}", self.to_json, @@avos_header)
#       response.body
#     end

#     def update(data = {})
#       @@httpclient.post(BASE_URL_"/#{@name}", data.to_json)
#     end

#     class << self
#       def create(name, data={})
#         res = @@httpclient.post(CLASS_URL+"/#{name}", data.to_json, @@avos_header)
#         binding.pry
#         p res
#       end

#       def all(name)
#         res = @@httpclient.get(CLASS_URL+"/#{name}", {}, @@avos_header)
#         JSON.parse(res.body)
#       end

#       def where(name, query={})
#         res = @@httpclient.get(CLASS_URL+"/#{name}", query, @@avos_header)
#         JSON.parse(res.body)["results"].map do |ob|
          
#         end
#       end

#       def update(name, data={})
#       end
#     end

#     def update(data={})
#     end
#   end
# end
