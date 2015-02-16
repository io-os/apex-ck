{ApexCKPaneView} = require './apex-ck-view'
{CompositeDisposable} = require 'atom'
path = require 'path'

module.exports = ApexCk =
  apexCkView: null
  modalPanel: null
  subscriptions: null
  pages: []

  activate: (state) ->
    #@apexCkView = new ApexCkView(state.apexCkViewState)
    # keep remembering how i should use this lol
    #@modalPanel = atom.workspace.addModalPanel(item: @apexCkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'apex-ck:new-file': => @command('newfile')
    @subscriptions.add atom.commands.add 'atom-workspace', 'apex-ck:toggle': => @toggle()

  ready: ->
    console.log 'Ckedit: READY!!'
    @isReady = true

  createPage: (url) ->
    page = new ApexCKPaneView()
    atom.workspace.activePane.activateItem page
    @pages.push page
    return page

  command: (str) ->
    console.log 'Ckedit: '+str
    if str is 'newfile'
      @createPage('ck:new')

  deactivate: ->
    #@modalPanel.destroy()
    @subscriptions.dispose()
    @apexCkView.destroy()

  serialize: ->
    # this could be tricky
    return {}
    # { apexCkViewState: @apexCkView.serialize() }

  toggle: ->
    console.log 'ApexCk was toggled!'

    #if @modalPanel.isVisible()
    #  @modalPanel.hide()
    #else
    #  @modalPanel.show()
