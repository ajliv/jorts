define [
    'underscore'
    'backbone'
], (_, Backbone) ->
    'use strict'

    class QuestionModel extends Backbone.Model
        defaults:
            value: false
            crop: ''
            full: ''
