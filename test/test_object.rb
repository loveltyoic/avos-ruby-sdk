require 'test_helper'
module AVOS
  describe Object do 
    before do 
      @set = AVOS::Object.new("Set")
      @set["name"] = "test"
    end

    it "init with data" do 
      set = AVOS::Object.new("Set", {name: "test", number: "42009"})
      res = set.save
      res.status.must_equal 201
      object = AVOS::Object.find("Set", set.avos_id)
      object["number"].must_equal "42009"
    end

    it "save" do 
      res = @set.save
      res.status.must_equal 201
      @set.avos_id.must_equal JSON.parse(res.body)["objectId"]
    end

    it "update" do 
      @set.save
      res = @set.update({number: "42030"})
      res.status.must_equal 200
    end

    it "find" do 
      @set["number"] = "42030"
      @set.save
      results = AVOS::Object.where("Set", {number: "42030"})
      results.wont_be_empty
    end

    it "return count" do 
      AVOS::Object.count("Set").must_be_kind_of Integer
    end

  end
end