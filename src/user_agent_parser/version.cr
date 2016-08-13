module UserAgentParser
  VERSION = "0.1.0"

  class Version
    # Private: Regex used to split string version string into major, minor,
    # patch, and patch_minor.
    SEGMENTS_REGEX = /\d+\-\d+|\d+[a-zA-Z]+$|\d+|[A-Za-z][0-9A-Za-z-]*$/

    getter! version : String
    @segments : Array(String) | Nil

    def to_s(io : IO)
      @version.to_s(io)
    end

    def initialize(*args)
      if args.size == 1 && args.first.is_a?(String)
        @version = args.first.to_s.strip
      else
        @segments = args.map(&.to_s).map(&.strip).to_a
        @version = segments.join(".")
      end
    end

    def major
      segments[0]
    end

    def minor
      segments[1]
    end

    def patch
      segments[2]
    end

    def patch_minor
      segments[3]
    end

    def inspect(io : IO)
      "#<#{self.class} #{to_s}>".to_s(io)
    end

    def eql?(other)
      return false if other.nil?
      self.class == other.class &&
        version == other.version
    end

    def ==(other)
      eql?(other)
    end

    # Private
    def segments : Array(String)
      @segments ||= begin
        ret = [] of String
        version.scan(SEGMENTS_REGEX) do |m|
          ret.push(m[0])
        end
        ret
      end
    end
  end
end
