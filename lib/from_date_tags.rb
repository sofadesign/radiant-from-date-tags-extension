module FromDateTags
  include Radiant::Taggable
  
  desc %{
    Inside this tag, all page related tags refer to the next children page 
    published from now.
    If there's no page, the contents of this tag is not rendered.
    You can use siblings tags to process each page after or before this.
    
    *Usage:*
    <pre><code><r:children:next_from_now>...</r:children:next_from_now></code></pre>
  }
  tag 'children:next_from_now' do |tag|
    found = tag.locals.page.children.find(:first, 
                  :conditions => ["published_at > ?", Time.now],
                  :order => "published_at ASC")
    if page_found?(found)
      tag.locals.page = found
      tag.expand
    end
  end
  
  desc %{
    Only renders the contents of this tag if the current page has some published 
    children page after now.
    
    *Usage:*
    <pre><code><r:children:if_next_from_now>...</r:children:if_next_from_now></code></pre>
  }
  tag 'children:if_next_from_now' do |tag|    
    found = tag.locals.page.children.find(:first, 
                  :conditions => ["published_at > ?", Time.now],
                  :order => "published_at ASC")
    if page_found?(found)
      tag.expand
    end
  end
  
  desc %{
    Only renders the contents of this tag if the current page has no published 
    children page after now.
    
    *Usage:*
    <pre><code><r:children:unless_next_from_now>...</r:children:unless_next_from_now></code></pre>
  }
  tag 'children:unless_next_from_now' do |tag|    
    found = tag.locals.page.children.find(:first, 
                  :conditions => ["published_at > ?", Time.now],
                  :order => "published_at ASC")
    if !page_found?(found)
      tag.expand
    end
  end
  
  # TODO:
  #
  # 'previous_from_now'
  # 'if_previous_from_now'
  # 'unless_previous_from_now'
  # 'next_from_date'
  # 'if_next_from_date'
  # 'unless_next_from_date'
  # 
  # 'previous_from_date'
  # 'if_previous_from_date'
  # 'unless_previous_from_date'
  #
end