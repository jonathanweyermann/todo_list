@List = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/lists/#{ @props.list.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteList @props.list
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.list.description
      React.DOM.td null, @props.list.completion_units
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
