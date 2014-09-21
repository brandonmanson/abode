$(document).ready(function() {
	$("input#expense_amount").on("focusout", function() {
		var newAmount = parseInt(this.value)
		var previousAmount = 0;
		$(".user_expense_portion").each(function(user){
			var value = parseInt(this.value);
			previousAmount += value;
		});
		$(".user_expense_portion").each(function(user){
			var currentPortion = this.value;
			this.value = currentPortion * newAmount / previousAmount;
		});
		$("#sum-of-portions").html(newAmount)
	});

	$(".user_expense_portion").on("focusout", function() {
		var sum = 0;
		$(".user_expense_portion").each(function(user) {
			var value = parseInt(this.value);
			sum += value
		});
		$("#sum-of-portions").html(sum)
	})
})