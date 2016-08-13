require "./user_agent_parser/*"

module UserAgentParser
  # TODO: load on compiling
  DefaultPatternsPath = File.join(File.dirname(__FILE__), "../vendor/uap-core/regexes.yaml")

  def self.parse(user_agent_string, pattern_path = "")
    Parser.new(pattern_path: pattern_path).parse(user_agent_string)
  end
end
