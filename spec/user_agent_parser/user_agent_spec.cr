require "../spec_helper.cr"

describe UserAgentParser::UserAgent do
  describe "#to_s" do
    it "returns a string of just the family" do
      UserAgentParser::UserAgent.new("Chrome").to_s.should eq "Chrome"
    end

    it "returns a string of family and version" do
      version = UserAgentParser::Version.new("1.2.3pre")
      agent = UserAgentParser::UserAgent.new("Chrome", version)
      agent.to_s.should eq "Chrome 1.2.3pre"
    end
  end

  describe "#initialize" do
    describe "with family" do
      it "sets family" do
        agent = UserAgentParser::UserAgent.new("Chromium")
        agent.family.should eq "Chromium"
      end
    end

    describe "with no family" do
      it "sets family to Other" do
        agent = UserAgentParser::UserAgent.new
        agent.family.should eq "Other"
      end
    end

    describe "with version" do
      it "sets version" do
        version = UserAgentParser::Version.new("1.2.3")
        agent = UserAgentParser::UserAgent.new(nil, version)
        agent.version.should eq version
      end
    end

    describe "with os" do
      it "sets os" do
        os = UserAgentParser::OperatingSystem.new("Windows XP")
        agent = UserAgentParser::UserAgent.new(nil, nil, os)
        agent.os.should eq os
      end
    end

    describe "with device" do
      it "sets device" do
        device = UserAgentParser::Device.new("iPhone")
        agent = UserAgentParser::UserAgent.new(nil, nil, nil, device)
        agent.device.should eq device
      end
    end
  end

  describe "#name" do
    it "returns family" do
      agent = UserAgentParser::UserAgent.new("Safari")
      agent.name.should eq agent.family
    end
  end

  describe "#==" do
    it "returns true for same agents with no OS" do
      version = UserAgentParser::Version.new("1.0")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version)
      agent1.should eq agent2
    end

    it "returns true for same agents on same OS" do
      version = UserAgentParser::Version.new("1.0")
      os = UserAgentParser::OperatingSystem.new("Windows")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version, os)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version, os)
      agent1.should eq agent2
    end

    it "returns false for same agent on different OS" do
      version = UserAgentParser::Version.new("1.0")
      windows = UserAgentParser::OperatingSystem.new("Windows")
      mac = UserAgentParser::OperatingSystem.new("Mac")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version, windows)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version, mac)
      agent1.should_not eq agent2
    end

    it "returns false for same os, but different browser version" do
      browser_version1 = UserAgentParser::Version.new("1.0")
      browser_version2 = UserAgentParser::Version.new("2.0")
      os = UserAgentParser::OperatingSystem.new("Windows")
      agent1 = UserAgentParser::UserAgent.new("Chrome", browser_version1, os)
      agent2 = UserAgentParser::UserAgent.new("Chrome", browser_version2, os)
      agent1.should_not eq agent2
    end
  end

  describe "#eql?" do
    it "returns true for same agents with no OS" do
      version = UserAgentParser::Version.new("1.0")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version)
      agent1.eql?(agent2).should be_true
    end

    it "returns true for same agents on same OS" do
      version = UserAgentParser::Version.new("1.0")
      os = UserAgentParser::OperatingSystem.new("Windows")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version, os)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version, os)
      agent1.eql?(agent2).should be_true
    end

    it "returns false for same agent on different OS" do
      version = UserAgentParser::Version.new("1.0")
      windows = UserAgentParser::OperatingSystem.new("Windows")
      mac = UserAgentParser::OperatingSystem.new("Mac")
      agent1 = UserAgentParser::UserAgent.new("Chrome", version, windows)
      agent2 = UserAgentParser::UserAgent.new("Chrome", version, mac)
      agent1.eql?(agent2).should be_false
    end

    it "returns false for same os, but different browser version" do
      browser_version1 = UserAgentParser::Version.new("1.0")
      browser_version2 = UserAgentParser::Version.new("2.0")
      os = UserAgentParser::OperatingSystem.new("Windows")
      agent1 = UserAgentParser::UserAgent.new("Chrome", browser_version1, os)
      agent2 = UserAgentParser::UserAgent.new("Chrome", browser_version2, os)
      agent1.eql?(agent2).should be_false
    end
  end

  describe "#inspect" do
    it "returns the family and version" do
      browser_version = UserAgentParser::Version.new("1.0")
      agent = UserAgentParser::UserAgent.new("Chrome", browser_version)
      agent.inspect.to_s.should eq "#<UserAgentParser::UserAgent Chrome 1.0>"
    end

    it "returns the OS if present" do
      browser_version = UserAgentParser::Version.new("1.0")
      os_version = UserAgentParser::Version.new("10.7.4")
      os = UserAgentParser::OperatingSystem.new("OS X", os_version)
      agent = UserAgentParser::UserAgent.new("Chrome", browser_version, os)
      agent.inspect.should eq "#<UserAgentParser::UserAgent Chrome 1.0 (OS X 10.7.4)>"
    end

    it "returns device if present" do
      browser_version = UserAgentParser::Version.new("5.0.2")
      os_version = UserAgentParser::Version.new("4.2.1")
      os = UserAgentParser::OperatingSystem.new("iOS", os_version)
      device = UserAgentParser::Device.new("iPhone")
      agent = UserAgentParser::UserAgent.new("Mobile Safari", browser_version, os, device)
      agent.inspect.should eq "#<UserAgentParser::UserAgent Mobile Safari 5.0.2 (iOS 4.2.1) (iPhone)>"
    end
  end
end
