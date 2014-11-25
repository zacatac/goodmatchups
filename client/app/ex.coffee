angular.module('todoApp').factory 'Task', ($resource) ->
  class Task
    constructor: (taskListId) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks/:id',
        {task_list_id: taskListId, id: '@id'})

    create: (attrs) ->
      new @service(task: attrs).$save (task) ->
        attrs.id = task.id
      attrs

    all: ->
      @service.query()