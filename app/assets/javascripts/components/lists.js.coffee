@lists = React.createClass
  getInitialState: ->
    lists: @props.data

  getDefaultProps: ->
    lists: []

  completed: ->
    completed = @state.lists.map (val) ->
      if val.finished_completion_units == null
        0
      else
        val.finished_completion_units
    completed.reduce ((prev, curr) ->
      prev + curr
    ), 0
  remaining: ->
    remaining = @state.lists.map (val) ->
      val.completion_units - val.finished_completion_units
    remaining.reduce ((prev, curr) ->
      prev + curr
    ), 0
  total: ->
    @completed() + @remaining()

  getChartData: ->
    $.get '/lists.json', (data) ->
      #$('.result').html data
      #alert 'Load was performed.'
      #@setState edit: false
      #@setState error: false
      #@props.handleEditList @props.list, data
      data

  addList: (list) ->
    lists = @state.lists.slice()
    lists.push list
    @setState lists: lists

  deleteList: (list) ->
    index = @state.lists.indexOf list
    lists = React.addons.update(@state.lists, { $splice: [[index, 1]] })
    @replaceState lists: lists

  updateList: (list, data) ->
    index = @state.lists.indexOf list
    lists = React.addons.update(@state.lists, { $splice: [[index, 1 , data]] })
    @replaceState lists: lists

  x_data: ->
    JSON.parse('[{"name":"Workout","data":{"2013-02-10":3,"2013-02-17":3,"2013-02-24":3,"2013-03-03":1,"2013-03-10":4,"2013-03-17":3,"2013-03-24":2,"2013-03-31":3}},{"name":"Go to concert","data":{"2013-02-10":0,"2013-02-17":0,"2013-02-24":0,"2013-03-03":0,"2013-03-10":2,"2013-03-17":1,"2013-03-24":0,"2013-03-31":0}},{"name":"Wash face","data":{"2013-02-10":0,"2013-02-17":1,"2013-02-24":0,"2013-03-03":0,"2013-03-10":0,"2013-03-17":1,"2013-03-24":0,"2013-03-31":1}},{"name":"Call parents","data":{"2013-02-10":5,"2013-02-17":3,"2013-02-24":2,"2013-03-03":0,"2013-03-10":0,"2013-03-17":1,"2013-03-24":1,"2013-03-31":0}},{"name":"Eat breakfast","data":{"2013-02-10":3,"2013-02-17":2,"2013-02-24":1,"2013-03-03":0,"2013-03-10":2,"2013-03-17":2,"2013-03-24":3,"2013-03-31":0}}]')

  render: ->
    new Chartkick.LineChart("user-chart", @x_data())
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Lists'
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @completed(), text: 'Completed'
        React.createElement AmountBox, type: 'danger', amount: @remaining(), text: 'Remaining'
        React.createElement AmountBox, type: 'info', amount: @total(), text: 'Total'
      React.createElement ListForm, handleNewList: @addList
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Finished Units'
            React.DOM.th null, 'Total Units'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for list in @state.lists
            React.createElement List, key: list.id, list: list, handleDeleteList: @deleteList, handleEditList: @updateList
