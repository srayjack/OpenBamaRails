class BotSniffer
  def self.bot_agents
    bot_agent_list.join("|")
  end

  def self.bot_agent_list
    [ "panscient", "larbin", "dummy", "Teoma", "alexa", 
      "froogle", "inktomi", "looksmart", "URL_Spider_SQL", 
      "Firefly", "NationalDirectory", "Ask Jeeves", "TECNOSEEK", 
      "InfoSeek", "WebFindBot", "crawler", "girafobot", "Scooter", 
      "Baidu", "bot", "Google", "SiteUptime", "Slurp", 
      "WordPress", "ZIBB", "ZyBorg", "msnbot", "check_http", 
      "libwww-perl", "lwp-trivial", "wget", "curl", "SimplePie", 
      "Python", "Feed", "HTTPClient", "Tumblr", "Spider", "sanszbot"]
  end

  def self.bot_agent_list_for_db
    "(" + BotSniffer.bot_agent_list.map{|a| "'#{a.downcase}'"}.join(",") + ")"    
  end

  def self.smells_like_a_bot?(user_agent)
    user_agent =~ /(#{bot_agents})/i        
  end
end