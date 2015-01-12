module AVOS
  class Relation
    attr_reader :data
    def initialize(relation_objects)
      @data = {
        "__op" => "AddRelation",
        "objects" => relation_objects.map do |object|
          object.save unless object.avos_id
          { "__type" => "Pointer","className" => object.klass_name,"objectId" => object.avos_id }
        end
      }
    end
  end
end