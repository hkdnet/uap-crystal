require "../spec_helper.cr"

describe UserAgentParser::Version do
  it "parses 1" do
    version = UserAgentParser::Version.new("1")
    version.major.should eq "1"
  end

  it "parses 1.2" do
    version = UserAgentParser::Version.new("1.2")
    version.major.should eq "1"
    version.minor.should eq "2"
  end

  it "parses 1.2.3" do
    version = UserAgentParser::Version.new("1.2.3")
    version.major.should eq "1"
    version.minor.should eq "2"
    version.patch.should eq "3"
  end

  it "parses 1.2.3b4" do
    version = UserAgentParser::Version.new("1.2.3b4")
    version.major.should eq "1"
    version.minor.should eq "2"
    version.patch.should eq "3"
    version.patch_minor.should eq "b4"
  end

  it "parses 1.2.3-b4" do
    version = UserAgentParser::Version.new("1.2.3-b4")
    version.major.should eq "1"
    version.minor.should eq "2"
    version.patch.should eq "3"
    version.patch_minor.should eq "b4"
  end

  it "parses 1.2.3pre" do
    version = UserAgentParser::Version.new("1.2.3pre")
    version.major.should eq "1"
    version.minor.should eq "2"
    version.patch.should eq "3pre"
  end

  it "parses 1.2.3-45" do
    version = UserAgentParser::Version.new("1.2.3-45")
    version.major.should eq "1"
    version.minor.should eq "2"
    version.patch.should eq "3-45"
  end

  it "accepts Fixnum and String arguments" do
    version = UserAgentParser::Version.new(1, "2a", 3, "4b")
    version.major.should eq "1"
    version.minor.should eq "2a"
    version.patch.should eq "3"
    version.patch_minor.should eq "4b"
  end

  describe "#to_s" do
    it "returns the same string as initialized with" do
      version = UserAgentParser::Version.new("1.2.3b4")
      version.to_s.should eq "1.2.3b4"
    end
  end

  describe "#==" do
    it "returns true for same versions" do
      version = UserAgentParser::Version.new("1.2.3")
      version.should eq UserAgentParser::Version.new("1.2.3")
    end

    it "returns false for different versions" do
      version = UserAgentParser::Version.new("1.2.3")
      version.should_not eq UserAgentParser::Version.new("1.2.2")
    end
  end

  describe "#inspect" do
    it "returns the class and version" do
      version = UserAgentParser::Version.new("1.2.3")
      version.inspect.should eq "#<UserAgentParser::Version 1.2.3>"
    end
  end
end
