{CompositeDisposable} = require 'atom'

module.exports = Epoch =
  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add "atom-workspace", 'epoch:convert': => @convert()

  notNaN: (n) ->
    return !isNaN(parseFloat(n)) && isFinite(n);

  convert: ->
    if selection = atom.workspace.getActivePaneItem().getSelections()[0]
      e = Date.parse(selection.getText())
      if @notNaN(e) is true
        e = e /1000 # milliseconds
        selection.insertText(e.toString())
    else
      console.log("Epoch unable to grab editor")
