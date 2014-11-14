Fission = require 'fission'
SyncAdapter = require 'fission-sync-localstorage'

fission = new Fission
  sync: SyncAdapter

module.exports = fission