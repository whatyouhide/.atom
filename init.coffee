# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

format = (path) ->
  childProcess = require 'child_process'
  cwd = atom.project.getPaths()[0] || "/"
  pandoc = childProcess.spawn "mix", ["format", path], {cwd: cwd}
  pandoc.stdout.on 'data', (d) -> console.log('stdout: ' + d);
  pandoc.stderr.on 'data', (d) -> console.log('stderr: ' + d);
  pandoc.on 'close', (c) -> console.log('child process exited with code ' + c);

atom.commands.add 'atom-text-editor', 'elixir:format', ->
  return unless editor = atom.workspace.getActiveTextEditor()
  path = editor.getPath()
  format(path)
