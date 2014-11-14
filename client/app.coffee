Fission = require 'fission'
SyncAdapter = require 'fission-sync-localstorage'

fission = new Fission
  sync: SyncAdapter

#fission = new Fission
#  sync: (method, model, options) ->
#    console.log model
#    return model

module.exports = fission