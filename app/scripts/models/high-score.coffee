define [
    'underscore'
    'backbone'
], (_, Backbone) ->
    'use strict'

    class HighScoreModel extends Backbone.Model
        defaults:
            Player:
                username: ''
            Score:
                score: 0