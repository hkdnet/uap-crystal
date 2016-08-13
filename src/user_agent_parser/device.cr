module UserAgentParser
  class Device
    getter family : String

    def name
      family
    end

    def initialize(@family = "Other")
    end

    def to_s(io : IO)
      family.to_s(io)
    end

    def inspect(io : IO)
      "#<#{self.class} #{to_s}>".to_s(io)
    end

    def eql?(other)
      self.class == other.class && family == other.family
    end

    def ==(other)
      eql?(other)
    end
  end
end
