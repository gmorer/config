local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require('beautiful').xresources.apply_dpi
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local popup_position = naughty.config.defaults.position

local capacity_path = "/sys/class/power_supply/BAT0/capacity"
local status_path = "/sys/class/power_supply/BAT0/status"

return function()

    local last_battery_check = os.time()
    local warningDisplayed = false

    local icon = ""

    local battery_widget = {}

    local icon_widget = wibox.widget {
        widget = wibox.widget.textbox,
    }
    local level_widget = wibox.widget {
        markup = "4%", 
        widget = wibox.widget.textbox
    }

    battery_widget = wibox.widget {
        icon_widget,
        level_widget,
        spacing = dpi(4),
        layout = wibox.layout.fixed.horizontal,
    }

    local time_remaining = ""
    local g_charge = 0
    local notification = nil

    function battery_widget:hide()
        if notification ~= nil then
            naughty.destroy(notification)
            notification = nil
        end
    end

    function battery_widget:show(t_out)
        battery_widget:hide()

        notification = naughty.notify({
            app_name = "battery",
            preset = fs_notification_preset,
            text = time_remaining .. " remaining",
            timeout = t_out,
            screen = mouse.screen,
            position = popup_position
        })
    end

    gears.timer {
        timeout   = 10,
        call_now  = true,
        autostart = true,
        callback  = function()
            awful.spawn.easy_async("cat " .. capacity_path .. " " .. status_path, function(stdout, _, _, _)
                local _, _, charge_str, status = string.find(stdout, "(%d+)\n(%a+)")
                local charge = tonumber(charge_str)
                if status == "Charging" then
                    icon = ""
                elseif (charge >= 0 and charge < 10) then
                    icon = ""
                    if os.difftime(os.time(), last_battery_check) > 300 or not warningDisplayed or charge < 3 then
                        -- if 5 minutes have elapsed since the last warning
                        last_battery_check = os.time()
                        warningDisplayed = true
                        require("notifications").battery(charge)
                    end
                elseif (charge < 20) then
                    icon = ""
                elseif charge < 30 then
                    icon = ""
                elseif charge < 40 then
                    icon = ""
                elseif charge < 50 then
                    icon = ""
                elseif charge < 60 then
                    icon = ""
                elseif charge < 70 then
                    icon = ""
                elseif charge < 80 then
                    icon = ""
                elseif charge < 90 then
                    icon = ""
                elseif charge < 100 then
                    icon = ""
                else
                    icon = ""
                end
                icon_widget.markup = "<span foreground='".. beautiful.fg_dark .."'>"..icon.."</span>"
                level_widget.markup = "<span foreground='".. beautiful.fg_dark .."'>"..charge.."%</span>"
                battery_widget:connect_signal('mouse::enter', function () battery_widget:show(0) end)
                battery_widget:connect_signal('mouse::leave', function () battery_widget:hide() end)
                -- if status then
                -- awful.spawn.easy_async_with_shell("xbacklight -15", function(stdout)
                -- end)
            end)
        end
    }
    return battery_widget
end
