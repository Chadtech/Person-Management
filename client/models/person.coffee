fission = require '../app'

module.exports = 
  fission.model
    props:
      name:
        first: 'string'
        last: 'string'
      alive: 'boolean'
      id: 'string'
    url: 'persons/api'