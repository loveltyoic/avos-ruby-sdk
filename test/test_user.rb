require 'test_helper'

module AVOS
  describe User do 
    before do 
      @user_info = {"username" => SecureRandom.hex(8), "password" => "1988224"}
      @user = AVOS::User.register(@user_info)
    end      

    it "register user" do 
      @user.avos_id.wont_be_nil
    end

    it "signin user" do 
      user = AVOS::User.signin(@user_info)
      user["username"].must_equal @user_info[:username]
    end

  end
end
