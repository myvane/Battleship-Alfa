module.exports = (app, dbManager) ->

  ###
   Gets all people
  ###
  app.get '/game/panel/', (request, respons) ->
    console.log "GET: /game/panel"

    respons.render 'panel_inicial'