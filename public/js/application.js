$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('#addanotherresponse').on('click', function() {
    $(".choice_form").append("<label name='response'>Choice </label>");
    $(".choice_form").append("<input name='response[]' type='text'><br><br>");
  })

  $('#new_question').on('submit', function(e) {
    e.preventDefault()

    var request = $.ajax({
      url: "/polls/" + $('.choice_form').data('form-id') + "/questions",
      method: "post",
      data: $(this).serialize() 
    });

    request.done(function(response) {
      $('#new_question').trigger("reset");
      $('#question_count').text(response.questioncount)
      console.log(response.questioncount)
    });
  });

  $('#complete_new_poll').on('click', function(e) {
    e.preventDefault()


  });


});

