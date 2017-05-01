@lists = React.createClass
  getInitialState: ->
    lists: @props.data

  getDefaultProps: ->
    lists: []

  addList: (list) ->
    lists = @state.lists.slice()
    lists.push list
    @setState lists: lists

  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Lists'
      React.createElement listform, handleNewList: @addList
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Completion Units'
        React.DOM.tbody null,
          for list in @state.lists
            React.createElement List, key: list.id, list: list
