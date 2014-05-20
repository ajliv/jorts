define [
    'underscore'
    'backbone'
], (_, Backbone) ->
    'use strict'

    class ScoreModel extends Backbone.Model
        url: 'https://api.scoreoid.com/v1/createScore'

        defaults:
            response: 'JSON'
            username: ''
            score: 0
            answered: 0
            wrong: 0

        initialize: () ->
            @set 
                api_key: JORTS.apiKey
                game_id: JORTS.gameID
                score: parseInt Math.random() * 1000, 1