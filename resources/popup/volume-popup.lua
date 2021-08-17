local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require('beautiful').xresources.apply_dpi

local naughty = require("naughty")

local createPopup = require("popup.popup")

local popup = createPopup("#000066")

awesome.connect_signal("init::volume", function(volume)
	popup.update(volume.value, volume.image)
end)

awesome.connect_signal("popup::volume", function(volume)
    if volume ~= nil then
        popup.updateValue(volume.amount)
    end
    popup.show()
end)
