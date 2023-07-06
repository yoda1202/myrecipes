// Configure your import map in config/importmap.rb.
// Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"
import "channels"

function scrollToBottom(){
  if($('#messages').length > 0) {
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

$(document).ready(function() {
  scrollToBottom();
});


// function scrollToBottom(){
//   if($('#messages').length > 0) {
//     $('#messages').scrollTop($('#messages')[0].scrollHeight);
//   }
// }

// function submitMessage(event){
//   event.preventDefault();
//   $('#new_message').submit();
// }

// $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
//   if (event.keyCode === 13) {
//     submitMessage(event);
//   }
// });

// $(document).on('click', '[data-send~=message]', function(event) {
//   submitMessage(event);
// });

// $(document).on('turbolinks:load', function() {
//   $("#new_message").on("ajax:complete", function(e, data, status) {
//     $('#message_content').val('');
//   })
//   scrollToBottom();
// });