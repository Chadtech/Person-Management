fission = require '../../app'

{div, p} = fission.React.DOM

module.exports =
  fission.view
    render: ->
      div {className:'content'},
        p {className:'point'},
          'Sorry, this page does not exist'