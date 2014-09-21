var app = angular.module('abode', ['ngResource', 'ngRoute']);

app.factory('Comment', ['$resource', '$location', function($resource, $location) {
  var url = $location.$$absUrl;
  var commentableId = url.substr(url.lastIndexOf('/') + 1);
  return $resource('/abodes/:id/comments', {}, {
    query: { method: 'GET', params: {id: commentableId},
    isArray:true}
  });
}]);

app.controller('CommentsCtrl', ['$scope', '$location', 'Comment', function($scope, $location, Comment) {
  $scope.comments = Comment.query();
}]);
