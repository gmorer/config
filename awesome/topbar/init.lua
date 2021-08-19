local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi
local battery = require("topbar.battery")()
local volume = require("topbar.volume")()
local net_widget = require("topbar.internet")({
  ignore_interfaces = {"lo", "tun0"}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

local widget = function(inner_widget)
    return wibox.widget {
        widget = wibox.container.margin,
        top = dpi(5), 
        bottom = dpi(5),
        left = dpi(6),
        right = dpi(6),
        {
            inner_widget,
            layout = wibox.layout.fixed.horizontal
        }
    }
end

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local color_solid = beautiful.bg_normal

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
         awful.button({ }, 1, function(t) t:view_only() end),
         awful.button({ modkey }, 1, function(t)
                 if client.focus then
                         client.focus:move_to_tag(t)
                 end
         end),
         awful.button({ }, 3, awful.tag.viewtoggle),
         awful.button({ modkey }, 3, function(t)
                 if client.focus then
                         client.focus:toggle_tag(t)
                 end
         end),
         awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
         awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
         awful.button({ }, 1, function (c)
                 if c == client.focus then
                         c.minimized = true
                 else
                         c:emit_signal(
                                 "request::activate",
                                 "tasklist",
                                 {raise = true}
                         )
                 end
         end),
         awful.button({ }, 3, function()
                 awful.menu.client_list({ theme = { width = 250 } })
         end),
         awful.button({ }, 4, function ()
                 awful.client.focus.byidx(1)
         end),
         awful.button({ }, 5, function ()
                 awful.client.focus.byidx(-1)
         end)
)

awful.screen.connect_for_each_screen(function(s)
    s.topbar = awful.wibar({
        position = "top",
	screen = s,
	bg = color_solid
    })
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }
    -- Add widgets to the wibox
    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
	spacing = 10,
	expand = "none",
        { -- Left widgets
            mylauncher,
            s.mytaglist,
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            wibox.widget.systray(),
	    widget(net_widget),
	    widget(volume),
	    widget(battery),
            mytextclock,
            layout = wibox.layout.fixed.horizontal,
        },
    }
end)
