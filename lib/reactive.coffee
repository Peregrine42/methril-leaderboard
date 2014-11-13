if Meteor.isClient
  window.reactive = (controller) ->
    return () ->
      instance = {}

      computation = Deps.autorun(() ->
        m.startComputation()
        controller.call(instance)
        m.endComputation()
      )

      instance.onunload = () ->
        computation.stop()

      return instance
