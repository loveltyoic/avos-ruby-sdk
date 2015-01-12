module AVOS
  mattr_accessor :app_key, :app_id
  class << self
    def init
      @@app_key = ENV["APP_KEY"]
      @@app_id = ENV["APP_ID"]
      yield self if block_given?
      @@client = AVOS::Client.new
    end
  end
end