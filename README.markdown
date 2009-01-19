# From Date Tags

Useful tags that return a child which published date is the next one after or before a given date. 
Great in conjunction with sibling\_tags extension.  
For example, it could be used if you want to treat each page as an event and show only the list of upcoming events.

## Example with children:next\_from\_now

This will display a list of children pages which published date is older than now.

    <r:children:next_from_now>
        <ul>
            <li>[<r:date format="%d.%m.%Y" />]: 
                <r:link><r:title /></r:link></li>
            
            <r:siblings:each_after by="published_at" order="asc">
                <li>[<r:date format="%d.%m.%Y" />]: 
                    <r:link><r:title /></r:link></li>
            </r:siblings:each_after>
        </ul>
    </r:children:next_from_now>