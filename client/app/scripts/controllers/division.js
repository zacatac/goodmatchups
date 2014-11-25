'use strict';
 
/**
 * @ngdoc function
 * @name goodmatchesApp.controller:DivisionsCtrl
 * @description
 * # DivisionsCtrl
 * Controller of the goodmatchesApp
 */

angular.module('goodmatchesApp')
    .controller('DivisionCtrl', ['$anchorScroll', '$location', '$rootScope','$scope', 'Division', 'DivisionTeams','SportStat', function ($anchorScroll, $location, $rootScope, $scope, Division, DivisionTeams, SportStat) {
	$scope.divisions = Division.all();	

	$scope.viewDivision = function(id) { 	    
	    $rootScope.selected = Division.one(id);
	    return $rootScope.selected;
	};	
	$scope.getTeams = function(id){
	    $rootScope.teams = DivisionTeams.query(id);
	};
	$scope.getStats = function(label){
	    $rootScope.stats = SportStat.show(label);
	};

	$scope.gotoAnchor = function(x) {
	    var newHash = x;
	    console.log(x);	    
	    if ($location.hash() !== newHash) {
		// set the $location.hash to `newHash` and
		// $anchorScroll will automatically scroll to it
		$location.hash(x);
	    } else {
		// call $anchorScroll() explicitly,
		// since $location.hash hasn't changed
		$anchorScroll();
	    }
	};
	

    }]);
