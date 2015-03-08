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
  module Hash
    extend ActiveSupport::Concern
    included do 
      extend Forwardable
      attr_accessor :hash
      def_delegators :@hash, :[]=, :merge!, :[], :to_avos_data
    end
  end
end