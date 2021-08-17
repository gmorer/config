local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require('beautiful').xresources.apply_dpi
 -- Left = 1
 -- Center = 2
 -- Right = 3
 -- WheelUp = 4
 -- WheelDown = 5
local GET_VOLUME_CMD = 'amixer -D pulse sget Master'

local icon_widget = {}

local handleVolume = {}

local updateVolume = function()
    awful.spawn.easy_async_with_shell(GET_VOLUME_CMD, function(stdout)
        handleVolume(stdout)
    end)
end

handleVolume = function(stdout)
    local mute = string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
    local volume = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
    volume = tonumber(string.format("% 3d", volume))

    local icon = ""

    if mute == 'off' then
        icon = "婢"
    elseif volume > 50 then
        icon = ""
    elseif volume > 10 then
        icon = ""
    else
        icon = ""
    end

    icon_widget.markup = "<span foreground='"..beautiful.fg_dark.."'>"..icon.."</span>"

    awesome.emit_signal("init::volume", {
        value = volume,
        image = icon
    })
end

return function()
    icon_widget = wibox.widget {
        widget = wibox.widget.textbox,
    }
    local volume_widget = wibox.widget({
        icon_widget,
        spacing = dpi(4),
        layout = wibox.layout.fixed.horizontal,
    })

    volume_widget:connect_signal('button::press', function(_, _, _, button)
        if button == 1 then -- left click
            awful.spawn.easy_async_with_shell("pamixer -t", function(stdout)
                updateVolume()
                awesome.emit_signal("popup::volume")
            end)
        elseif button == 4 then -- up
            awful.spawn.easy_async_with_shell("pactl set-sink-volume 0 +3%", function(stdout)
                updateVolume()
                awesome.emit_signal("popup::volume", {amount = 3})
            end)
        elseif button == 5 then -- down
            awful.spawn.easy_async_with_shell("pactl set-sink-volume 0 -3%", function(stdout)
                updateVolume()
                awesome.emit_signal("popup::volume", {amount = -3})
            end)
        end
    end)

    watch(GET_VOLUME_CMD, 10, function(_, stdout, _, _, _)
        handleVolume(stdout)
    end, nil)
    return volume_widget
end

