module UserAgentParser
  class UserAgent
    getter family : String
    getter version : UserAgentParser::Version?
    getter os : UserAgentParser::OperatingSystem?
    getter device : UserAgentParser::Device?

    def name
      family
    end

    def initialize(family = nil, @version = nil, @os = nil, @device = nil)
      @family = family || "Other"
    end

    def to_s
      string = family
      string += " #{version.to_s}" if version
      string
    end

    def inspect
      string = to_s
      string += " (#{os.to_s})" if os
      string += " (#{device.to_s})" if device
      "#<#{self.class} #{string}>"
    end

    def eql?(other)
      self.class == other.class &&
        family == other.family &&
        version == other.version &&
        os == other.os
    end

    def ==(other)
      eql?(other)
    end
  end
end
