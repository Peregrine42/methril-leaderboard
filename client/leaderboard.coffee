# Leaderboard view model
Leaderboard = {}

# selected player
Leaderboard.selectedPlayerID = null

# application actions
Leaderboard.players = () ->
  return PlayerList.find({}, {sort: {score: -1}}).fetch()

Leaderboard.select = (player) ->
  Leaderboard.selectedPlayerID = player._id

Leaderboard.selected = (player) ->
  return Leaderboard.selectedPlayerID == player._id

Leaderboard.givePoints = () ->
  if (Leaderboard.selectedPlayerIDi?)
    PlayerList.update({_id: Leaderboard.selectedPlayerID}, {$inc: {score: 5}})

# controller
#Meteor.startup(() ->
Leaderboard.controller = window.reactive(() ->
  this.players = Leaderboard.players()
)
#)

# view
Leaderboard.view = (ctrl) ->
  return [
    m("ul", [
      ctrl.players.map((player) ->
        params =
          style: { background: if Leaderboard.selected(player) then "yellow" else "" }
          onclick: Leaderboard.select.bind(this, player)
        return m("li", params, player.name + ": " + player.score)
      )
    ]),
    m("button", { onclick: Leaderboard.givePoints }, "Give 5 points")
  ]

Meteor.startup(() ->
  m.module(document, Leaderboard)
)
