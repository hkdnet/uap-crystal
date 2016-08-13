module UserAgentParser
  class Device
    getter family : String

    def name
      family
    end

    def initialize(@family = "Other")
    end

    def to_s
      family
    end

    def inspect
      "#<#{self.class} #{to_s}>"
    end

    def eql?(other)
      self.class == other.class && family == other.family
    end

    def ==(other)
      eql?(other)
    end
  end
end
