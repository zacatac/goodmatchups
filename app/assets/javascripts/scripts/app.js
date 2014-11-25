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
	    var labelToIndex = {
		'ACC' : 0,
		'AAC' : 1,      
		'BIG-12' : 2,
		'BIG-TEN' : 3,
		'CONFERENCE-USA' : 4,
		'IA-INDEPENDENTS' : 5,
		'MID-AMERICAN' : 6,
		'MOUNTAIN-WEST' : 7, 
		'PAC-12' : 8,
		'SEC' : 9,
		'SUN-BELT' : 10
	    };
    	    return this.service.show({id: labelToIndex[label]});
    	};

	return new SportStat();
    }])
    .run(['$anchorScroll', function($anchorScroll) {
	$anchorScroll.yOffset = 250;   // always scroll by 50 extra pixels
    }]);
