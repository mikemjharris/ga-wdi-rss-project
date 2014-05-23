xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link posts_url

    for article in @particles
      xml.item do
        xml.title article.title
        xml.description artilce.content
        xml.pubDate article.posted_at.to_s(:rfc822)
        xml.link article.url
        xml.guid article.guid
        xml.image article.image
      end
    end
  end
end