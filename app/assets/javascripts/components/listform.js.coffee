@listform = React.createClass
  getInitialState: ->
    description: ''
    completion_units: ''

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/lists', { list: @state }, (data) =>
      @props.handleNewList data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Completion Units'
          name: 'completion_units'
          value: @state.completion_units
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create task'

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  valid: ->
    @state.description && @state.completion_units
