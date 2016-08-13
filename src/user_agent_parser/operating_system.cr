module UserAgentParser
  class OperatingSystem
    getter family : String
    getter version : UserAgentParser::Version?

    def name
      family
    end

    def initialize(@family = "Other", @version = nil)
    end

    def to_s(io : IO)
      string = family
      string += " #{version}" if version
      string.to_s(io)
    end

    def inspect(io : IO)
      "#<#{self.class} #{to_s}>".to_s(io)
    end

    def eql?(other)
      return false if other.nil?
      self.class == other.class &&
        family == other.family &&
        version == other.version
    end

    def ==(other)
      eql?(other)
    end
  end
end
