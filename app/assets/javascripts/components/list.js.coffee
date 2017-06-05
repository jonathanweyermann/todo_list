@List = React.createClass
  getInitialState: ->
    edit: false
    error: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/lists/#{ @props.list.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteList @props.list

  handleEdit: (e) ->
    e.preventDefault()
    data =
      description: @refs.description.value
      finished_completion_units: @refs.finished_completion_units.value
      completion_units: @refs.completion_units.value
    @triggerUpdate(data)

  addUnit: (e) ->
    data =
      description: @props.list.description
      finished_completion_units: @props.list.finished_completion_units + 1
      completion_units: @props.list.completion_units
    @triggerUpdate(data)
    e.preventDefault()

  removeUnit: (e) ->
    data =
      description: @props.list.description
      finished_completion_units: @props.list.finished_completion_units - 1
      completion_units: @props.list.completion_units
    @triggerUpdate(data)
    e.preventDefault()

  triggerUpdate: (data) ->
    $.ajax
      method: 'PUT'
      url: "/lists/#{ @props.list.id }"
      dataType: 'JSON'
      data:
        list: data
      success: (data) =>
        @setState edit: false
        @setState error: false
        @props.handleEditList @props.list, data
      error: (XMLHttpRequest, textStatus, errorThrown) =>
        @setState error: true

  listRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.list.description
      React.DOM.td null,
        React.DOM.div
          className: 'col-sm-4'
          @props.list.finished_completion_units
        React.DOM.div
          className: 'col-sm-8'
          React.DOM.a
            className: 'btn btn-primary'
            onClick: @addUnit
            '+'
          React.DOM.a
            className: 'btn btn-primary'
            onClick: @removeUnit
            '-'
      React.DOM.td null, @props.list.completion_units
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-primary'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  listForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.list.description
          ref: 'description'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.list.finished_completion_units
          ref: 'finished_completion_units'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.list.completion_units
          ref: 'completion_units'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @listForm()
    else
      @listRow()
