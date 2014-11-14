express = require 'express'
app = express()
http = require 'http'
{join} = require 'path'

PORT = Number process.env.PORT or 8090

app.use express.static join __dirname, 'public'

app.use (error, request, response, next) ->
  console.error error.stack
  response.send 500, 'SOMETHING BROKE'

app.get '/*', (request, response) ->
  adminFile = join __dirname, 'public/admin.html'
  response.status 200
    .sendFile adminFile

httpServer = http.createServer app

httpServer.listen PORT, ->
  console.log 'SERVER RUNNING ON ' + PORT