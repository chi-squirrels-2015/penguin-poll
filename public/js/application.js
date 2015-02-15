$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $("#addquestion").on('click', function(event) {
    event.preventDefault();
    // var payload = $(this).serialize();
    var request = $.ajax({
      url: "/polls",
      type: "POST",
      data: $(this).parents("form").serialize()
    });

    request.done(function(response) {
      $("#new_poll").append(response);
      $("#addquestion").remove();
    });
  });

  $(document).on('click', "#addresponses", function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: "/questions",
      type: "POST",
      data: $(this).parents("form").serialize()
    });

    request.done(function(response) {
      $("#new_poll").append(response);
      $("#addresponses").remove();
    });
  });

 $(document).on('click', "#addanotherresponse", function(event) {
    event.preventDefault();

    var request = $.ajax({
      url: "/responses",
      method: "post",
      data: $(this).parents("form").serialize()
    });

    request.done(function(response) {
      console.log("INSIDE done");
      console.log(response);
      // Uncomment these two lines and comment out the one below the two
      $(".response").remove();
      $("#new_poll").append(response);
      // $(".response").append(response);
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
