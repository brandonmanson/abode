var app = angular.module('abode', ['ngResource', 'ngRoute']);

// app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
//   $routeProvider.
//   when('/abodes/:id/comments', {
//     controller: 'CommentsCtrl',
//     template: ' '
//   });

//   $locationProvider.html5Mode(true);
//   $locationProvider.hashPrefix('!');
// }]);

// app.factory('Comment', ['$resource', function($resource) {
//   $resource('/abodes/:abodeId/comments', {abodeId: '@abodeId'});
// }]);

app.factory('Comment', ['$resource', '$location', function($resource, $location) {
  var url = $location.$$absUrl;
  var commentableId = url.substr(url.lastIndexOf('/') + 1);
  return $resource('/abodes/:id/comments', {}, {
    query: { method: 'GET', params: {id: commentableId},
    isArray:true}
  });
}]);


// app.controller('CommentsCtrl', ['$scope', '$resource', '$routeParams', function($scope, $resource) {
//   var Comments = $resource('/abodes/' + $routeParams.abodeId + '/comments');
//   $scope.comments = Comments.query();
// }]);

// app.controller('CommentsCtrl', ['$scope', '$resource', '$routeParams', function($scope, $resource) {
//   var Comments = $resource('/abodes/1/comments');
//   $scope.comments = Comments.query();
// }]);

app.controller('CommentsCtrl', ['$scope', '$location', 'Comment', function($scope, $location, Comment) {
  $scope.comments = Comment.query();
}]);
