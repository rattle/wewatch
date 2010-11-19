$('#broadcast<%= @broadcast.id %>').replaceWith('<%= escape_javascript(render(:partial => "/pages/broadcast", :locals => {:broadcast => @broadcast})) %>');

