'use strict';
 
/**
 * @ngdoc function
 * @name goodmatchesApp.controller:StatCtrl
 * @description
 * # StatCtrl
 * Controller of the goodmatchesApp
 */

angular.module('goodmatchesApp')
    .controller('StatsCtrl', ['$rootScope', '$scope', 'SportStat', function ($rootScope, $scope, SportStat) {
	// $rootScope.stats = SportStat.get();
	$scope.getStats = function(label) { 
	    $rootScope.stats = SportStat.show(label);	    
	};	
    }]);
