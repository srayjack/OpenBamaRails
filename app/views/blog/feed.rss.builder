xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "OpenBama Blog"
    xml.description "OpenBama is a non-partisan website that compiles data from various sources pertaining to Alabama State government into an easy to use tool. OpenBama desires to inspire the citizens of Alabama to demand more transparency within state and local government."
    xml.link "http://openbama.org/blog"

    for post in @posts
      
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post.post_url
        xml.guid post.post_url
      end
    end
  end
end