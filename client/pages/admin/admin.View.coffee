fission = require '../../app'
Person = require '../../models/person'

{div, p, form, input, canvas} = fission.React.DOM

deletePrompts =
  remove: 'Remove'
  verify: 'Are you sure?'

editPrompts =
  edit: 'Edit'
  save: 'Save'

personView = fission.modelView
  model:Person

  remove: ->
    @model.destroy()

  getInitialState: ->
    deleteState: 'remove'
    editState: 'edit'
    firstNameValue: ''
    lastNameValue: ''

  deleteHandle: ->
    if @state.deleteState is 'remove'
      @setState deleteState: 'verify'
    else if @state.deleteState is 'verify'
      @model.destroy()

  handleFirstNameEditInput: (event) ->
    @setState firstNameValue: event.target.value

  handleLastNameEditInput: (event) ->
    @setState lastNameValue: event.target.value

  editHandle: ->
    if @state.editState is 'edit'
      @setState editState: 'save'
      @setState firstNameValue: @model.get('name').first
      @setState lastNameValue: @model.get('name').last
    else if @state.editState is 'save'
      @model.set 'name', 
        first:   @state.firstNameValue
        last:    @state.lastNameValue
      @model.save()
      @setState editState: 'edit'
      @setState firstNameValue: ''
      @setState lastNameValue: ''
  
  aliveStatus: ->
    status = 'alive'
    if not (@model.get 'alive')
      status += ' false'
    return status

  editStatus: ->
    status = 'input'
    if @state.editState is 'edit'
      status += ' hidden'
    return status

  canvasHandle: ->
    if @state.editState is 'save'
      @model.set 'alive', (not @model.get 'alive')

  render: ->
    div {className: 'row'},
      
      div {className: 'column'},
        p {className: 'point'}, 
          @model.get('name').first
        input
          className: @editStatus()
          value:     @state.firstNameValue
          onChange:  @handleFirstNameEditInput

      
      div {className: 'column'},
        p {className: 'point'},
          @model.get('name').last
        input
          className: @editStatus()
          value:     @state.lastNameValue
          onChange:  @handleLastNameEditInput
      
      div {className: 'column'},
        canvas
          onClick: @canvasHandle
          className: @aliveStatus()
      
      div {className: 'column'},
        input 
          className: 'submit'
          type:      'submit'
          onClick:    @deleteHandle
          value:      deletePrompts[@state.deleteState]
      
      div {className: 'column'},
        input 
          className: 'submit'
          type:      'submit'
          onClick:   @editHandle
          value:     editPrompts[@state.editState]

      div {className: 'column'},
        p {className: 'point'},
          @model.get('id')

module.exports =
  fission.collectionView
    model:Person
    itemView: personView
    submitValues: ['Add', 'Edit']
    addOrEdit: 0
    alive: true
    updateAliveStatus: (living) ->
      status = 'alive'
      if not living
        status += ' false'
      return status
    toggleAlive: ->
      @alive = not @alive
      document.getElementById('aliveStatus').className = @updateAliveStatus(@alive)
    addPerson: ->
      firstName = document.getElementById('firstNameField').value
      lastName = document.getElementById('lastNameField').value
      @collection.create name:{first:firstName, last:lastName}, alive:@alive
      document.getElementById('firstNameField').value = ''
      document.getElementById('lastNameField').value = ''
    render: ->
      div {className: 'content'},
        div {className: 'spacer'}
        div {className: 'indent'},
          div {className: 'container'},
            
            div {className: 'row'},
              
              div {className: 'column super'},
                p {className:'point'}, 'Person Management Admin Panel'
            
            div {className:'row'},
              div {className:'column'}
            
            div {className: 'row'},
              
              div {className: 'column'},
                form {className: 'formTitle'},
                  'first name'
                  input {id:'firstNameField', className: 'input'}
              
              div {className: 'column'},
                form {className: 'formTitle'},
                  'last name'
                  input {id:'lastNameField', className: 'input'}
              
              div {className: 'column'},
                form {className: 'formTitle'},
                  'status'
                  canvas {id:'aliveStatus', className:'alive', onClick:@toggleAlive}
              
              div {className: 'column'},
                input {className:'submit add', type:'submit', value:@submitValues[@addOrEdit], onClick:@addPerson} 
            
            div {className:'row'},
              div {className:'column'}
            
            @items.map (item) ->
              item