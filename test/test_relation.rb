require 'test_helper'
module AVOS
  describe Relation do 
    before do 
      @post = AVOS::Object.new("Post", {title: "test post"})
      @post.save
      @comment = AVOS::Object.new("Comment", {content: "test comment"})
    end

    it "add relation objects" do 
      @post["comment"] = @comment
      @post.save
    end
  end
end