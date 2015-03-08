require 'test_helper'

module AVOS
  describe Query do 
    before do 
      @set = AVOS::Object.new("Set")
      @set["name"] = "test"
      @set["number"] = "42030"
      @set.save
      @query = AVOS::Query.new("Set")
    end

    it "find by where clause" do 
      results = @query.where({number: "42030"})
      results.wont_be_empty
    end

    it "find by id" do 
      object = @query.find(@set.avos_id)
      object["number"].must_equal "42030"
    end

    it "return count" do 
      @query.count.must_be_kind_of Integer
    end
  end
end