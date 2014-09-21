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
	})
})