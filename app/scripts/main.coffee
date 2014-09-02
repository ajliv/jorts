#/*global require*/
'use strict'

require.config
    shim:
        underscore:
            exports: '_'
        backbone:
            deps: [
                'underscore'
                'jquery'
            ]
            exports: 'Backbone'
    paths:
        jquery: '../bower_components/jquery/dist/jquery'
        backbone: '../bower_components/backbone/backbone'
        underscore: '../bower_components/underscore/underscore'
        bootstrap: '../bower_components/bootstrap/dist/js/bootstrap'

require [
    'underscore'
    'backbone'
    'views/app'
], (_, Backbone, AppView) ->
    window.JORTS =
        apiKey: '3bfd78557fa3e2970eda35fbb9a6238a8612ba3f'
        gameID: '79f4f32de9'
        questions: QUESTIONS

    new AppView

    Backbone.history.start()
