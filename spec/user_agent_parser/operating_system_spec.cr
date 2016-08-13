require "../spec_helper.cr"

describe UserAgentParser::OperatingSystem do
  describe "#name" do
    it "returns family" do
      os = UserAgentParser::OperatingSystem.new("Windows")
      os.name.should eq os.family
    end
  end

  describe "#to_s" do
    it "returns a string of just the family" do
      os = UserAgentParser::OperatingSystem.new("Windows")
      os.to_s.should eq "Windows"
    end

    it "returns a string of family and version" do
      version = UserAgentParser::Version.new("7")
      os = UserAgentParser::OperatingSystem.new("Windows", version)
      os.to_s.should eq "Windows 7"
    end
  end

  describe "#==" do
    it "returns true for same user agents across different O/S's" do
      version = UserAgentParser::Version.new("7")
      os1 = UserAgentParser::OperatingSystem.new("Windows", version)
      os2 = UserAgentParser::OperatingSystem.new("Windows", version)
      os1.should eq os2
    end

    it "returns false for same family, different versions" do
      seven = UserAgentParser::Version.new("7")
      eight = UserAgentParser::Version.new("8")
      os1 = UserAgentParser::OperatingSystem.new("Windows", seven)
      os2 = UserAgentParser::OperatingSystem.new("Windows", eight)
      os1.should_not eq os2
    end

    it "returns false for different family, same version" do
      version = UserAgentParser::Version.new("7")
      os1 = UserAgentParser::OperatingSystem.new("Windows", version)
      os2 = UserAgentParser::OperatingSystem.new("Blah", version)
      os1.should_not eq os2
    end
  end

  describe "#eql?" do
    it "returns true for same user agents across different O/S's" do
      version = UserAgentParser::Version.new("7")
      os1 = UserAgentParser::OperatingSystem.new("Windows", version)
      os2 = UserAgentParser::OperatingSystem.new("Windows", version)
      os1.eql?(os2).should be_true
    end

    it "returns false for same family, different versions" do
      seven = UserAgentParser::Version.new("7")
      eight = UserAgentParser::Version.new("8")
      os1 = UserAgentParser::OperatingSystem.new("Windows", seven)
      os2 = UserAgentParser::OperatingSystem.new("Windows", eight)
      os1.eql?(os2).should be_false
    end

    it "returns false for different family, same version" do
      version = UserAgentParser::Version.new("7")
      os1 = UserAgentParser::OperatingSystem.new("Windows", version)
      os2 = UserAgentParser::OperatingSystem.new("Blah", version)
      os1.eql?(os2).should be_false
    end
  end

  describe "#inspect" do
    it "returns class family and instance to_s" do
      version = UserAgentParser::Version.new("10.7.4")
      os = UserAgentParser::OperatingSystem.new("OS X", version)
      os.inspect.to_s.should eq "#<UserAgentParser::OperatingSystem OS X 10.7.4>"
    end
  end
end
