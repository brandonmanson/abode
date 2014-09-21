var app = angular.module('abode', ['ngResource', 'ngRoute']);

app.factory('Comment', ['$resource', '$location', function($resource, $location) {
  var url = $location.$$absUrl;
  var commentableId = url.substr(url.lastIndexOf('/') + 1);
  return $resource('/abodes/:id/comments', {}, {
    query: {method: 'GET', params: {id: commentableId},
    isArray:true},
    save: {method: 'POST', params: {id: commentableId}}
  });
}]);

app.controller('CommentsCtrl', ['$scope', '$location', 'Comment', function($scope, $location, Comment) {
  $scope.comments = Comment.query();

  $scope.addComment = function() {
    comment = Comment.save($scope.newComment);
    $scope.comments.push(comment);
    $scope.newComment = {};
  };
}]);
