-- vim: sw=2:sts=2:et:
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local module_path = "topbar"
local watch = require("awful.widget.watch")
local dpi = require('beautiful').xresources.apply_dpi

local fg_dark = "#cccccc"

return function(args)
  local args = args or {}
  -- Settings
  local interfaces = args.interfaces
  local ignore_interfaces = args.ignore_interfaces or {}
  local timeout = args.timeout or 10
  local font = args.font or beautiful.font
  local onclick = args.onclick
  local popup_position = args.popup_position or naughty.config.defaults.position

  -- Turn off advanced details by default
  if args.skipcmdline == nil then
    args.skipcmdline = true
  end

  local theme = beautiful.get()

  local wifi_icon = "直 "
  local ethernet_icon = " "
  local vpn_icon = "嬨 "
  local no_connection_icon = "睊 "
  local indicator = {}

  local function get_iface_icon(s)
    if (s.is_vpn) then
      return vpn_icon
    elseif (s.is_wifi) then
      return wifi_icon
    elseif (s.is_eth) then
      return ethernet_icon
    end
    return ""
  end

  local net_widget = {}

  local icon_widget = wibox.widget {
      widget = wibox.widget.textbox,
  }

  local net_widget = wibox.widget {
      icon_widget,
      spacing = dpi(4),
      layout = wibox.layout.fixed.horizontal,
  }
  local real_interfaces = nil
  local function text_grabber()
    if not real_interfaces then
      return "Interface data not loaded"
    end
    local msg = ""
    for _, s in pairs(real_interfaces) do
      msg = msg .. "\n"
      msg = msg .. "┌ " .. get_iface_icon(s).. " " .. s.iface
      if s.is_vpn then
        msg = msg .. " - VPN"
      elseif s.state then  -- not a VPN but we have state
        msg = msg .. " - state is " .. s.state
      end
      msg = msg .. "\n"

      -- Show IP and MAC addresses
      for a = 1, #s.addrs - 1 do
        msg = msg .. "├ADDR:\t" .. s.addrs[a].addr ..
              " (" .. s.addrs[a].type_ .. ")\n"
      end
      msg = msg .. "└ADDR:\t" .. s.addrs[#s.addrs].addr ..
            " (" .. s.addrs[#s.addrs].type_ .. ")\n"
    end
    if msg == "" then
      return "No internet connection"
    else
      return string.gsub(string.gsub(msg, '^\n', ""), '\n$', "")
    end
  end  -- function text_grabber()

  local notification = nil
  function net_widget:hide()
    if notification ~= nil then
      naughty.destroy(notification)
      notification = nil
    end
  end

  function net_widget:show(t_out)
    net_widget:hide()

    notification = naughty.notify({
        app_name = "network",
        preset = fs_notification_preset,
        text = text_grabber(),
        timeout = t_out,
        screen = mouse.screen,
        position = popup_position
      })
  end


  watch("ip -oneline link show", 10, function(widget, stdout, stderr, exitreason, exitcode)
--   end, nil)
--   return net_widget
-- end
  real_interfaces = nil

-- --[[
    -----------------------
    -- This function fetches the latest info about a given interface
    -- It makes use of `io.popen` so we only run it asynchronously
    -- It updates the global variable `real_interfaces`
    -- It only processes the interfaces listed in the `interfaces` argument
    -- If that argument is blank it will process all interfaces
    -----------------------
    local function get_interfaces()
      ----
      -- First, get the `links` table of all link data for relevant interfaces
      ----
      local links = {}
      -- All on one line:
      -- 2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
      --    state UP mode DEFAULT group default qlen 1000\ link/ether
      --    1c:6f:65:3f:48:9a brd ff:ff:ff:ff:ff:ff
      -- 32: br-39d5fbb21742: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
      --    noqueue state DOWN mode DEFAULT group default \    link/ether
      --    02:42:68:08:88:34 brd ff:ff:ff:ff:ff:ff
      local ipl_pattern = "^%d+:%s+([^%s]+):%s+<.*>%s.*%s" ..
          "state%s+([^%s]+)%s.*%slink/([^%s]+)[%s]*([%x:]*)"
      -- split by lines
      for line in stdout:gmatch("([^\n]*)\n?") do
        local iface, state, type_, mac = string.match(line, ipl_pattern)
        if not iface then
          notification = naughty.notify({
            app_name = "network",
            preset = fs_notification_preset,
            text = "LINE: \n" .. line,
            timeout = t_out,
            screen = mouse.screen,
            position = popup_position
          })
          goto continue_iplink
        end

        for _, i in pairs(ignore_interfaces) do
          if (i == iface) then
            goto continue_iplink  -- ignore this interface
          end
        end
        if interfaces then
          for _, i in pairs(interfaces) do
            if (i == iface) then
              goto donotignore_iplink  -- do not ignore this link
            end
          end
          goto continue_iplink  -- ignore this link
        end
        ::donotignore_iplink::  -- IS in the list of interfaces to process

        links[iface] = {
          iface = iface,
          state = state,
          type_ = type_,
          mac = mac,
          is_vpn = false,
          is_wifi = false,
          is_eth = false
        }
        ::continue_iplink::  -- is NOT in the list of interfaces to process
      end

      ----
      -- Next, get the `ifaces` to be a sequence of tables with data about each
      -- relevant interface
      ----
      -- TODO document all the fields in each `links[iface]` table
      local ifaces = {}

      -- Grab address information
      -- All on one line:
      -- 2: enp3s0    inet 192.168.1.190/24 brd 192.168.1.255 scope global \
      --    link/ether 1c:6f:65:3f:48:9a brd ff:ff:ff:ff:ff:ff
      local ipa_pattern = "^%d+:%s+([^%s]+)%s+([^%s]+)%s+([^%s]+)"
      local f = io.popen("ip -oneline addr show")
      for line in f:lines() do
        local iface, type_, addr = string.match(line, ipa_pattern)
        if not links[iface] then
          goto continue_ipaddr  -- is NOT in the list of interfaces to process
        end
        if not links[iface].addrs then
          -- First addr for this iface
          links[iface].addrs = {}
          table.insert(ifaces, links[iface])
        end
        table.insert(links[iface].addrs, {addr = addr, type_ = type_})
        ::continue_ipaddr::  -- is NOT in the list of interfaces to process
      end
      f:close()

      -- TODO add checks for more vpn types, e.g., l2tp/ipsec, pptp, etc
      -- Auto-detect VPN interfaces
      for iface, s in pairs(links) do
        if iface:match("^tun") then
          -- TUN/TAP devices are never in an "UP" state, but if there's a
          -- running process associated with it, it's probably connected
          s.is_vpn = true
        elseif iface:match("^wlan") then
          s.is_wifi = true
        elseif iface:match("^en") then
          s.is_eth = true
        end
      end

      for _, s in ipairs(links) do
        table.insert(ifaces, s)
      end
      return ifaces
    end  -- function get_interfaces()

    local displayed = ""
    local function net_update()
      -- Refresh interface data
      real_interfaces = get_interfaces()

      -- Grab interface state, set icon
      for _, s in pairs(real_interfaces) do
        if s.is_vpn then
          if displayed ~= "" then displayed = displayed .. "  " end
          displayed = displayed .. vpn_icon
        elseif s.state == "UP" then
          if displayed ~= "" then displayed = displayed .. "  " end
          displayed = displayed .. get_iface_icon(s)
        end
      end  -- for each real_interface
      if displayed == "" then
        displayed = no_connection_icon
      end
      icon_widget.markup = "<span foreground='"..fg_dark.."'>"..displayed.."</span>"
      return true
    end
    net_update()

    -- Bind onclick event function
    if onclick then
      net_widget:buttons(awful.util.table.join(
          awful.button({}, 1, function() awful.util.spawn(onclick) end)
      ))
    end

    net_widget:connect_signal('mouse::enter', function () net_widget:show(0) end)
    net_widget:connect_signal('mouse::leave', function () net_widget:hide() end)
  end, nil)
  return net_widget
end
-- --]]
