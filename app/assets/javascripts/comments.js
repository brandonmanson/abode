var app = angular.module('abode', ['ngResource', 'ngRoute']);

app.factory('Comment', ['$resource', '$location', function($resource, $location) {
  var url = $location.$$absUrl;
  var commentableType = url.split('/')[3];
  var commentableId = url.substr(url.lastIndexOf('/') + 1);
  return $resource('/:commentableType/:id/comments', {}, {
    query: {method: 'GET', params: {commentableType: commentableType, id: commentableId},
    isArray:true},
    save: {method: 'POST', params: {commentableType: commentableType, id: commentableId}}
  });
}]);

app.controller('CommentsCtrl', ['$scope', '$location', 'Comment', function($scope, $location, Comment) {
  $scope.comments = Comment.query();

  $scope.addComment = function() {
    if ($scope.newComment) {
      comment = Comment.save($scope.newComment);
      $scope.comments.push(comment);
      $scope.newComment = null;
    }
  };
}]);
