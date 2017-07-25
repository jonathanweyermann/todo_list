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
    $.getJSON '/lists.json', (data) ->
      new Chartkick.BarChart("user-chart", data, min: 0, max: 100)

  getPieChartData: ->
    $.getJSON '/pie.json', (data) ->
      new Chartkick.PieChart("pie-chart", data)

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

  render: ->
    #new Chartkick.LineChart("user-chart", @x_data(), min: 0, max: 20)
    @getChartData()
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
