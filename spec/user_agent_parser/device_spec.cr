require "../spec_helper.cr"

describe UserAgentParser::Device do
  describe "#name" do
    it "returns family" do
      os = UserAgentParser::Device.new("iPod")
      os.name.should eq os.family
    end
  end

  describe "#to_s" do
    it "returns a string of just the family" do
      os = UserAgentParser::Device.new("iPod")
      os.to_s.should eq "iPod"
    end
  end

  describe "#==" do
    it "returns true for same family" do
      device1 = UserAgentParser::Device.new("iPod")
      device2 = UserAgentParser::Device.new("iPod")
      device1.should eq device2
    end

    it "returns false different family" do
      device1 = UserAgentParser::Device.new("iPod")
      device2 = UserAgentParser::Device.new("iPad")
      device1.should_not eq device2
    end
  end

  describe "#eql?" do
    it "returns true for same family" do
      device1 = UserAgentParser::Device.new("iPod")
      device2 = UserAgentParser::Device.new("iPod")
      device1.eql?(device2).should be_true
    end

    it "returns false different family" do
      device1 = UserAgentParser::Device.new("iPod")
      device2 = UserAgentParser::Device.new("iPad")
      device1.eql?(device2).should be_false
    end
  end

  describe "#inspect" do
    it "returns class family and instance to_s" do
      device = UserAgentParser::Device.new("iPod")
      device.inspect.to_s.should eq "#<UserAgentParser::Device iPod>"
    end
  end
end
