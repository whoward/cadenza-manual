
$(document).ready(function() {
   function nextId() { return ("_id" + nextId.counter++); }
   nextId.counter = 0;

   $("<section/>").attr("id", "summary").insertAfter("#content > h1");

   $("<ul/>").appendTo("#summary");

   $("#content h2").each(function() {
      var id = nextId();
      var $this = $(this);

      $this.attr("id", id);

      var item = $("<li/>").appendTo("#summary ul");

      $("<a/>").attr("href", "#" + id).html($this.text()).appendTo(item);
   });
});