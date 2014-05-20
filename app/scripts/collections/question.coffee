define [
  'underscore'
  'backbone'
  'models/question'
], (_, Backbone, QuestionModel) ->

  class QuestionCollection extends Backbone.Collection
    model: QuestionModel