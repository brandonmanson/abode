$(document).ready(function(){
  $("#new-expense-form-container").on("submit", 'form#new_expense', function(event) {
    event.preventDefault();
    var action = $(this).attr('action');
    var data = $(this).serialize();
    request = $.ajax(action, {method: "post", data: data});
    request.done(function(response) {
      // debugger;
      $("#new-expense-form-container").html(response);
      fetch_abode_expenses();
    });
  });

  var fetch_abode_expenses = function() {
    var action = "/abodes/expenses"
    request = $.ajax(action, {method: "get"});
    request.done(function(response) {
      $("#expenses-list").html(response);
    })
  }

});
