app.factory('Expense', ['$resource', function($resource) {
  return $resource('/abodes/expenses', {}, {});
}]);

app.controller('ExpensesCtrl', ['$scope', 'Expense', function($scope, Expense) {
  $scope.expenses = Expense.query();

  $scope.addExpense = function() {
    if ($scope.newExpense) {
      expense = Expense.save($scope.newExpense);
      $scope.expenses.push(expense);
      $scope.newExpense = null;
    }
  };
}]);
