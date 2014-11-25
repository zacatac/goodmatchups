'use strict';
 
/**
 * @ngdoc function
 * @name goodmatchesApp.controller:TeamCtrl
 * @description
 * # TeamCtrl
 * Controller of the goodmatchesApp
 */

angular.module('goodmatchesApp')
    .controller('TeamCtrl', ['$rootScope', '$scope', 'Team', 'DivisionTeams', function ($rootScope, $scope, Team, DivisionTeams) {	
	$scope.teams = Team.all();	
	$scope.viewTeam = function(id) { 
	    $scope.selected = Team.one(id);
	};	
	
	$scope.getTeamsForDivision = function(id){
	    $rootScope.teams = DivisionTeams.query(id);
	};
    }]);
