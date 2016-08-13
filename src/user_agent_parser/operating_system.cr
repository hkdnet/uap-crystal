module UserAgentParser
  class OperatingSystem
    getter family : String
    getter version : UserAgentParser::Version?

    def name
      family
    end

    def initialize(@family = "Other", @version = nil)
    end

    def to_s
      string = family
      unless version.nil?
        string += " #{version.to_s}"
      end
      string
    end

    def inspect
      "#<#{self.class} #{to_s}>"
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
