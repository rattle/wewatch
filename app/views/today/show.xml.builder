xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.wewatch {

@broadcasts.each do |broadcast|
  xml.broadcast {
    xml.title broadcast.title
    xml.start broadcast.start
    xml.end broadcast.end
    xml.duration broadcast.duration
    xml.link broadcast.link
    xml.channel {
      xml.name broadcast.channel.name
    }
    xml.description broadcast.synopsis
    xml.watchers broadcast.intentions.count.to_i
  }

end
}