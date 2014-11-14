fission = require '../../app'
Person = require '../../models/person'

{div, p, form, input, canvas} = fission.React.DOM

personView = fission.modelView
  model:Person
  fetchPerson: ->
    console.log 'A', @model.get('id')
  getJSON: ->
    console.log 'B', @model.toJSON()
  render: ->
    div {className:'content'},
      p {className:'point'},
        'This is account'
      input {type:'submit', value:'Get Id', onClick:@fetchPerson}
      input {type:'submit', value:'Get JSON', onClick:@getJSON}

module.exports = personView