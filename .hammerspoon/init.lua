local hyper = {'ctrl', 'option'}
local hyper2 = {'alt'}
local hyper3 = {'alt', 'shift'}

-- Init speaker.
speaker = hs.speech.new()

-- Yabai
local yabai = "/usr/local/bin/yabai -m"
local windows = {'1', '2', '3', '4', '5', '6'}

-- applications: alt [hjkl]
local key2App = {
  h = '/Applications/Google Chrome.app',
  j = '/Applications/Alacritty.app',
  k = '/Applications/Emacs.app',
}
for key, appPath in pairs(key2App) do
  hs.hotkey.bind(
    hyper, key,
    function()
      hs.application.launchOrFocus(appPath)
  end)
end

-- Spaces:  Alt + [NUM]
for i, v in ipairs(windows) do
  hs.hotkey.bind(
    hyper2, v,
    function()
      local command = "%s space --focus %s"
      hs.execute(string.format(command, yabai, v))
      hs.alert.closeAll()
      hs.alert.show("space: " .. v)
  end)
end

-- Rotate windows clockwise and anticlockwise
hs.hotkey.bind(
  hyper2, 'r',
  function()
    local command = "%s space --rotate 90"
    hs.execute(string.format(command, yabai, v))
end)


--- Move to workspace: Shift + Alt + [NUM]
for i, v in ipairs(windows) do
  hs.hotkey.bind(
    hyper3, v,
    function()
      local command = "%s window --space %s && %s space --focus %s"
      hs.execute(string.format(command, yabai, v, yabai, v))
  end)
end



local spaceIcon = hs.menubar.new()

-- Reload config.
hs.hotkey.bind(
    hyper, "'", function ()
        speaker:speak("Offline to reloading...")
        hs.reload()
end)

-- We put reload notify at end of config, notify popup mean no error in config.
hs.notify.new({title="Manatee", informativeText="Andy, I am online!"}):send()

-- Speak something after configuration success.
speaker:speak("Andy, I am online!")
