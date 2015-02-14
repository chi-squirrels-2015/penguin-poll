$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $("#addquestion").on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: "/polls",
      type: "POST",
      data: $(this).serialize()
    });

    request.done(function(response) {
      $("#new_poll").append(response);
      $("#addquestion").remove();
    });
    });

  //   // console.log('Click was received!');
  //   var question = "<label for='question-text'>Poll Question</label><input id='question-text' type='text' name='questions[text][]'>";
  //   var choice = "<p></p><label for='response'>Possible Response</label><input type='text' name='questions[choices][]'>";
  //   $('#poll_question').append(question);
  //   $('#poll_question').append(choice);
  //   $('#poll_question').append(choice);
  //   $('#poll_question').append(choice);
  //   $('#poll_question').append(choice);
  //   $('#poll_question').append(choice);
  // });
});
