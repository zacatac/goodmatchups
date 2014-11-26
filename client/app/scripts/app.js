'use strict';

/**
 * @ngdoc overview
 * @name goodmatchesApp
 * @description
 * # goodmatchesApp
 *
 * Main module of the application.
 */
angular
    .module('goodmatchesApp', [
	'ngAnimate',
	'ngCookies',
	'ngResource',
	'ngRoute',
	'ngSanitize',
	'ngTouch'
    ])
    .config(function ($routeProvider) {
	$routeProvider
	    .when('/', {
		templateUrl: 'views/divisions.html',
		controller: 'DivisionCtrl'
	    })
	    .when('/contact', {
	    	templateUrl: 'views/contact.html'
	    })
	    .when('/about', {
		templateUrl: 'views/about.html',
		controller: 'AboutCtrl'
	    })
	    .when('/divisions', {
		templateUrl: 'views/divisions.html',
		controller: 'DivisionCtrl'
	    })
	    .when('/teams', {
		templateUrl: 'views/teams.html',
		controller: 'TeamCtrl'
	    })
	    .when('/stats', {
		templateUrl: 'views/stats.html',
		controller: 'StatsCtrl'
	    })
	    .otherwise({
		redirectTo: '/'
	    });
    })
    .factory('Team', ['$resource', function($resource) {
	function Team(){
	    this.service = $resource('/api/teams/:id.json', {id: '@id'}, {
		'create':  { method: 'POST' },
		'index':   { method: 'GET', isArray: true },
		'show':    { method: 'GET', isArray: false },
		'update':  { method: 'PUT' },
		'destroy': { method: 'DELETE' }
		// 'query':   { method: 'GET', isArray: true, url:'/api/teams/query/:id'}
	    });
	    this.asdf = $resource('/api/teams/query/:id', {id: '@id'});

	}

	Team.prototype.all = function () {
	    return this.service.index();
	};

	Team.prototype.q = function (id) {
	    return this.asdf(id);
	    // return this.query.division(id);
	};
	
	// Team.prototype.one = function(id) {
	//     return this.service.show({id: id});
	// };

	return new Team();
    }])
    .factory('Division', ['$resource', function($resource) {
    	function Division(){
    	    this.service = $resource('/api/divisions/:id.json', {id: '@id'}, {
    		'create':  { method: 'POST' },
    		'index':   { method: 'GET', isArray: true },
    		'show':    { method: 'GET', isArray: false },
    		'update':  { method: 'PUT' },
    		'destroy': { method: 'DELETE' }
    	    });
    	}

    	Division.prototype.all = function () {
    	    return this.service.index();
    	};
	
    	Division.prototype.one = function(id) {
    	    return this.service.show({id: id});
    	};

    	return new Division();
    }])
    .factory('DivisionTeams', ['$resource', function($resource) {
    	function DivisionTeams(){
    	    this.service = $resource('/api/teams/query/:id.json', {id: '@id'}, {
    		'query': { method: 'GET', isArray: true }
    	    });
    	}
	
    	DivisionTeams.prototype.query = function(id) {
    	    return this.service.query({id: id});
    	};

	return new DivisionTeams();
    }])
    .factory('SportStat', ['$resource', function($resource) {
    	function SportStat(){
    	    this.service = $resource('/api/stats/:id.json', {id: '@id'}, {
    		'show': { method: 'GET', isArray: false }
    	    });
    	}
	
    	SportStat.prototype.show = function(label) {
    	    return this.service.show({id: label});
    	};

	return new SportStat();
    }]);


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
	    var data = SportStat.show(label);
	    if ('error' in data){
		$rootScope.error = data.error;
	    } else {		
		$rootScope.stats = data;
	    }
	};	
    }]);

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

/**
 * @ngdoc function
 * @name goodmatchesApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the goodmatchesApp
 */

angular.module('goodmatchesApp')
    .controller('AboutCtrl', [function() {
	
    }]);

/**
 * @ngdoc function
 * @name goodmatchesApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the goodmatchesApp
 */
angular.module('goodmatchesApp')
    .controller('MainCtrl', function ($scope) {
	$scope.awesomeThings = [
	    'HTML5 Boilerplate',
	    'AngularJS',
	    'Karma'
	];
    });

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
