define [
    'jquery'
    'underscore'
    'backbone'
    'templates'
    'views/main-menu'
    'views/high-scores'
    'views/submit-score'
    'views/game'
    'views/loser'
    'models/score'
    'collections/question'
    'collections/high-score'
], ($, _, Backbone, JST, MainMenuView, HighScoresView, SubmitScoreView, GameView, LoserView, ScoreModel, QuestionCollection, HighScoresCollection) ->
    class AppView extends Backbone.View
        el: '#app'

        events: 
            'click .play-button': 'begin'
            'click .main-menu-button': 'showMainMenu'
            'click .leaderboard-button': 'showHighScores'

        initialize: () ->
            @highScores = new HighScoresCollection
            @model = new ScoreModel
            @nav = @$ '#app-nav'
            @content = @$ '#app-content'

            @listenToOnce @highScores, 'reset', @render
            @listenTo @model, 'change:answered', @onAnswer

            JORTS.vent.on 'score:submit', @showHighScores, @
            JORTS.vent.on 'error', @render, @

            @highScores.getScores()

        render: () ->
            @showMainMenu()
            @

        show: (view, hideNav) ->
            @content.html view.el
            if hideNav is true then @$('#app-nav').hide() else @$('#app-nav').show()
            @

        begin: () -> 
            console.log 'begin'
            @questions = new QuestionCollection _.shuffle JORTS.questions
            @model.set score: 0
            @show new GameView( model: @model, collection: @questions ).render()
            @

        showHighScores: () ->
            console.log 'showHighScores'
            @show new HighScoresView collection: @highScores
            @

        showMainMenu: () ->
            console.log 'showMainMenu'
            @show new MainMenuView, true
            @

        onAnswer: () ->
            console.log 'onAnswer'
            
            return false unless @model.get('wrong') >= 3

            if @model.get('score') > @highScores.minimum or @highScores.length < 10
                @show new SubmitScoreView
                    model: @model
                    collection: @highScores 
            else
                @show new LoserView model: @model

            @