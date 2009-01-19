module FromDateTags
  include Radiant::Taggable
  
  desc %{
    Inside this tag, all page related tags refer to the next children page 
    published from now.
    If there's no page, the contents of this tag is not rendered.
    You can use siblings tags to process each page after or before this.
    
    *Usage:*
    <pre><code><r:children:next_from_now [status="published"]>...</r:children:next_from_now></code></pre>
  }
  tag 'children:next_from_now' do |tag|
    found = tag.locals.page.children.find(:first, children_from_date_options(tag, "published_at ASC"))
    if page_found?(found)
      tag.locals.page = found
      tag.expand
    end
  end
  
  desc %{
    Only renders the contents of this tag if the current page has some published 
    children page after now.
    
    *Usage:*
    <pre><code><r:children:if_next_from_now [status="published"]>...</r:children:if_next_from_now></code></pre>
  }
  tag 'children:if_next_from_now' do |tag|    
    found = tag.locals.page.children.find(:first, children_from_date_options(tag, "published_at ASC"))
    if page_found?(found)
      tag.expand
    end
  end
  
  desc %{
    Only renders the contents of this tag if the current page has no published 
    children page after now.
    
    *Usage:*
    <pre><code><r:children:unless_next_from_now [status="published"]>...</r:children:unless_next_from_now></code></pre>
  }
  tag 'children:unless_next_from_now' do |tag|    
    found = tag.locals.page.children.find(:first, children_from_date_options(tag, "published_at ASC"))
    if !page_found?(found)
      tag.expand
    end
  end
  
  def children_from_date_options(tag, order)
    attr = tag.attr.symbolize_keys
    
    options = {}
    options[:order] = order 
    status = (attr[:status] || 'published').downcase
    unless status == 'all'
      stat = Status[status]
      unless stat.nil?
        options[:conditions] = ["(virtual = ?) and (status_id = ?) and (published_at > ?)", false, stat.id, Time.now]
      else
        raise TagError.new(%{`status' attribute of `next_from_now' tag must be set to a valid status})
      end
    else
      options[:conditions] = ["(virtual = ?) and (published_at > ?)", false, Time.now]
    end
    options
  end
  
  # TODO:
  #
  # 'previous_from_now'
  # 'if_previous_from_now'
  # 'unless_previous_from_now'
  # 'next_from_date'
  # 'if_next_from_date'
  # 'unless_next_from_date'
  # 'previous_from_date'
  # 'if_previous_from_date'
  # 'unless_previous_from_date'
  #
end