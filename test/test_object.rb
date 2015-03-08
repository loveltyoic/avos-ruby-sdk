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
      res.must_equal true
    end

    it "save" do 
      res = @set.save
      res.must_equal true
    end

    it "update" do 
      @set.save
      res = @set.update({number: "42030"})
      res.must_equal true
    end

  end
end