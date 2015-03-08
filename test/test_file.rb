require 'test_helper'
module AVOS
  describe File do 
    before do 
      @file = AVOS::File.new(::File.expand_path("../test.png", __FILE__))
      @file.upload("42024.png")
    end

    it "upload image" do 
      @file["name"].must_equal "42024.png"
    end

    it "accociate file with object" do 
      set = AVOS::Object.new("Set", {name: "image test"})
      set["number"] = "8110"
      set["image"] = @file
      set.save
      query = AVOS::Query.new("Set")
      avos_set = query.find(set.avos_id)
      avos_set["image"]["objectId"].must_equal @file["objectId"]
    end
  end
end