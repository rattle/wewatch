// These are set to match the carousel added properties
w = $('li#broadcast<%= @broadcast.id %>').width();
h = $('li#broadcast<%= @broadcast.id %>').height();

$('#broadcast<%= @broadcast.id %>').replaceWith('<%= escape_javascript(render(:partial => "/pages/broadcast", :locals => {:broadcast => @broadcast})) %>');
$('li#broadcast<%= @broadcast.id %>').css('overflow', 'visible');
$('li#broadcast<%= @broadcast.id %>').css('float', 'left');
$('li#broadcast<%= @broadcast.id %>').width(w);
$('li#broadcast<%= @broadcast.id %>').height(h);

