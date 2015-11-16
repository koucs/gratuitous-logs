xml.instruct! :xml, :version => "1.0"
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "WevSTAT Blog by kou_cs POSTS"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.summary_contents
        # xml.pubDate post.created_at.in_time_zone(@user.time_zone).to_s(:rfc822)
        xml.pubDate post.created_at.to_s(:rfc822)
        if request.port == 80
          xml.guid "http://#{request.host}/articles/#{post.id}"
          xml.link "http://#{request.host}/articles/#{post.id}"
        else
          xml.guid "http://#{request.host}:#{request.port.to_s}/articles/#{post.id}"
          xml.link "http://#{request.host}:#{request.port.to_s}/articles/#{post.id}"
        end
      end
    end
  end
end