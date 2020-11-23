local hyper = {'ctrl', 'option'}
local hyper2 = {'shift', 'option'}
local hyper3 = {'option'}

-- Init speaker.
speaker = hs.speech.new()

-- Yabai
local yabai = "/usr/local/bin/yabai -m"
local windows = {'1', '2', '3', '4', '5', '6'}
-- applications: hyper2 [hjkl]
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


-- Spaces:  hyper3 + [NUM]
for i, v in ipairs(windows) do
  hs.hotkey.bind(
    hyper3, v,
    function()
      local command = "%s space --focus %s"
      hs.execute(string.format(command, yabai, v))
      hs.alert.closeAll()
      hs.alert.show("space: " .. v)
  end)
end

-- Rotate windows: hyper2 + r
hs.hotkey.bind(
  hyper2, 'r',
  function()
    local command = "%s space --rotate 90"
    hs.execute(string.format(command, yabai, v))
end)


-- Move to workspace: hyper2 + [NUM]
for i, v in ipairs(windows) do
  hs.hotkey.bind(
    hyper2, v,
    function()
      local command = "%s window --space %s && %s space --focus %s"
      hs.execute(string.format(command, yabai, v, yabai, v))
  end)
end

-- # Windows: hyper2 + [DIR]

local directions = {
  h = 'west',
  j = 'south',
  k = 'north',
  l = 'east'
}

for key, v in ipairs(directions) do
  hs.hotkey.bind(
    hyper2, key,
    function()
      local command = "%s window --focus %s"
      hs.execute(string.format(command, yabai, v))
  end)
end

-- Reload config.
hs.hotkey.bind(
    hyper, "'", function ()
        speaker:speak("Offline to reloading...")
        hs.reload()
end)

-- We put reload notify at end of config, notify popup mean no error in config.
hs.notify.new({title="Cizel", informativeText="Andy, I am online!"}):send()

-- Speak something after configuration success.
speaker:speak("Andy, I am online!")
