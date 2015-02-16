{Emitter} = require 'emissary'
urlUtil   = require 'url'
{$, View}  = require 'atom'
path = require 'path'

class ApexCKPaneView extends View
  Emitter.includeInto @

  @content: ->
    @div class: 'ck-pane-view', =>
      @tag 'apex-ck-editor', outlet: 'editor'

  initialize: (params) ->
    console.log 'ckpaneview init'
    @editor.element.setPaneView @

  createTab: ->
    tabBarView = atom.workspaceView.find('.pane.active').find('.tab-bar').view()
    tabView = tabBarView.tabForItem @
    $tabView = $ tabView
    @tabView = $tabView
    @setTitle 'CK Editor'

  destroy: ->
    #super
    tabBarView  = atom.workspaceView.find('.pane.active').find('.tab-bar').view()
    tabView     = tabBarView?.tabForItem? @

    if tabView
      $tabView    = $ tabView
      $tabView.remove()

    @tabView = $tabView = null

  getClass:     -> ApexCKPaneView
  getViewClass: -> ApexCKPaneView
  getView:      -> @
  getPath:      -> 'ckeditor://'

  setTitle: (@title) ->
    if @tabView then @tabView.find('.title').text(@title)
  getTitle: -> @title


# the editor view
window.totalCKInstances = 0
class ApexCKEditor extends HTMLElement

  createdCallback: ->
    totalCKInstances++
    @ck_id = "ckeditor_"+totalCKInstances

    @el = $(@)
    @paneView = @el.closest('.ck-pane-view')[0]

    console.log 'ApexCkView - Created'
    frame = document.createElement 'iframe'
    @frame = $ frame
    frame.id = @ck_id
    frame.width = '100%'
    frame.height = '100%'
    @frame.css 'width', '100%'
    @frame.css 'height', '100%'
    @frame.attr 'frameBorder', '0'
    @frame.css 'border', 'none'
    frame.src = 'file://' + path.join(__dirname,'editor.html')
    @el.append @frame

  setPaneView: (view) ->
    @paneView = view
    console.dir @paneView
    @paneView?.createTab()

document.registerElement 'apex-ck-editor', prototype: ApexCKEditor.prototype

module.exports = { ApexCKEditor: ApexCKEditor, ApexCKPaneView: ApexCKPaneView }

# fuck
