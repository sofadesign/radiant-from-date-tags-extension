class FromDateTagsExtension < Radiant::Extension
  version "1.0"
  description "Useful tags that return a page for a given date"
  url "http://github.com/sofadesign/radiant-from-date-tags-extension/tree/master"

  def activate
    Page.send :include, FromDateTags
  end
  
end