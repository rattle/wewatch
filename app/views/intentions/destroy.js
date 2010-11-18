$('#broadcast<%= @intention.broadcast_id %>').attr('href', '<%= intentions_path(:broadcast_id => @intention.broadcast_id)%>');
$('#broadcast<%= @intention.broadcast_id %>').attr('data-method', 'post');
$('#broadcast<%= @intention.broadcast_id %> span.buttontext').text('Watch');
$('#broadcast<%= @intention.broadcast_id %>').removeClass('watching');
