local awful = require("awful")
local beautiful = require("beautiful")

local createPopup = require("popup.popup")

local popup = createPopup("#660000")

awful.spawn.easy_async("xbacklight -get", function (stdout, stderr, reason, exit_code)
    local value = tonumber(stdout)
    if value == nil then
	    popup.update(50, " ")
    else
        popup.update(value, " ")
    end
end)

awesome.connect_signal("popup::brightness", function(brightness)
    popup.updateValue(brightness.amount)
    popup.show()
end)
