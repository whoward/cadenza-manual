
# generator function to get a unique ID for the page
uniqueId = -> "_id#{uniqueId.counter++}"
uniqueId.counter = 0

$(document).ready ->
   
   # create a table of contents in any div with id=summary
   $("#summary").each ->
      summary = $(this)

      container = $("<ul/>").appendTo(summary)

      $("#content h2").each ->
         id = uniqueId()
         h2 = $(this)

         h2.attr "id", id

         item = $("<li/>").appendTo(container)

         $("<a/>").attr("href", "##{id}").html(h2.text()).appendTo(item)

   # mark the current major tab as active
   $("#content nav a[href=\"#{window.location.pathname}\"]").addClass("active")