define [
    'jquery'
    'underscore'
    'backbone'
    'models/high-score'
], ($, _, Backbone, HighScoreModel) ->

    class HighScoreCollection extends Backbone.Collection
        model: HighScoreModel

        url: 'https://api.scoreoid.com/v1/getBestScores?game_id=79f4f32de9&api_key=3bfd78557fa3e2970eda35fbb9a6238a8612ba3f&response=JSON&limit=10&order_by=score'

        initialize: () ->
            @on 'reset', @setMinimum, @
            @minimum = 0

        getScores: (success) ->
            $.ajax
                type: 'POST'
                crossDomain: true
                url: @url
                success: (data) => 
                    @reset data
                    success?()

        setMinimum: () ->
            lastScore = @.last().get('Score').score
            @minimum = parseInt lastScore, 10

        fetch: () -> false