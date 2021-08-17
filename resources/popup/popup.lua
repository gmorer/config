local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require('beautiful').xresources.apply_dpi

local apply_borders = require("lib.borders")

local custom_notification_icon = wibox.widget {
    font = "FiraMono Nerd Font 28",
    align = "right",
    valign = "center",
    widget = wibox.widget.textbox
}

local createPopup = function(color)
    local icon = wibox.widget {
        font = "Fira Mono 28",
        align = "center",
        valign = "center",
        widget = custom_notification_icon,
        forced_width = dpi(64),
    }

    local progressbar = wibox.widget {
        value         = 1,
        color		  = color,
        background_color = beautiful.misc2,
        forced_width = dpi(150),
        -- shape = function(cr, width, height)
        --     gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
        -- end,
        shape = gears.shape.rounded_bar,
        forced_height  = 20,
        widget        = wibox.widget.progressbar
    }

    local widget = apply_borders({
        {
            icon,
            {
                nil, 
                progressbar,
                nil, 
                expand = "none",
                layout = wibox.layout.align.vertical
            }, 
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal,
        },
        -- top = dpi(8),
        -- left = dpi(8),
        -- right = dpi(8),
        widget = wibox.container.background
    }, 300, 72, 8)

    local popup = awful.popup {
        widget = widget,
        -- y            = awful.screen.focused().geometry.height / 2 - 72,
        y            = 30 + dpi(5),
        -- x            = awful.screen.focused().geometry.width - 48,
        x            = awful.screen.focused().geometry.width - dpi(230),
        shape        = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
        end,
        bg           = beautiful.bg_normal,
        ontop        = true,
        visible      = false,
    }

    popup:connect_signal("button::press", function() popup.visible = false end)

    local timer_die = gears.timer { timeout = 3 }

    popup.show = function()
        if timer_die.started then
            timer_die:again()
        else
            timer_die:start()
        end
        popup.visible = true
    end

    -- Hide popup after timeout
    timer_die:connect_signal("timeout", function()
        popup.visible = false
        -- Prevent infinite timers events on errors.
        if timer_die.started then
            timer_die:stop()
        end
    end)

    popup.update = function(value, image)
        icon.markup = "<span foreground='"..beautiful.fg_normal.."'>"..image.."</span>"
        progressbar.value = value / 100
    end

    popup.updateValue = function(value)
        if value ~= nil then
            progressbar.value = progressbar.value + (value / 100)
            if progressbar.value > 1 then
		    progressbar.value = 1
            elseif progressbar.value < 0 then
		    progressbar.value = 0
	    end
        end
    end

    return popup
end

return createPopup
