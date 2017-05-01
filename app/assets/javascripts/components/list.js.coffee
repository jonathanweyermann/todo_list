@List = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.list.description
        React.DOM.td null, @props.list.completion_units
