require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful") -- Theme handling library
require("naughty")   -- Notification library
require("vicious")   --Wiget Library

-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/pothix/theme3.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

screencount = screen.count()

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.magnifier,
  awful.layout.suit.floating,
  awful.layout.suit.max,
  awful.layout.suit.tile
}

-- Define a tag table which will hold all screen tags.
tags = {
  names  = { "∙", "⠡", "⠲", "⠵", "⠻", "⠿"},
  layout = {
    layouts[2], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]
  }
}
for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- Create a laucher widget and a main menu
myawesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
  }
})

mylauncher = awful.widget.launcher({
  image = image(beautiful.awesome_icon),
  menu = mymainmenu
})


-- Separators
spacer = widget({ type = "textbox" })
space = widget({ type = "textbox" })
separator = widget({ type = "textbox" })
vertline = widget({ type = "textbox" })
dash = widget({ type = "textbox" })
spacer.text = "  "
space.text = " "
separator.text = "||"
vertline.text = "|"
dash.text = "-"

mytextclock = awful.widget.textclock({ align = "right" }, "%d/%m %H:%M")
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(awful.button({}, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev))
mytasklist = {}
mytasklist.buttons = awful.util.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize the client, if needed
        client.focus = c
        c:raise()
    end
end),
  awful.button({}, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width = 250 })
    end
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end))


for s = 1, screencount do
  -- Set a screen margin for borders
  awful.screen.padding(screen[s], { top = 0 })
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- WARNING: In order to properly view the tasklist some lua files have been modified. For the
  -- tasklist_floating_icon icon to be placed on the left side of the task name instead of the
  -- right alignment, /usr/share/awesome/lib/awful/widget/tasklist.lua in function new(label, buttons) the
  -- variable widgets.textbox has to be modified like this:
  -- remove bg_align = "right" and
  -- modify the left margin from 2 to icon width + 2 (i.e.: 18).

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(function(c)
    return awful.widget.tasklist.label.currenttags(c, s,
      -- WARNING: Requires modified /usr/share/awesome/lib/awful/widget/tasklist.lua !!!
      -- This basically hides the application icons on the tasklist. If you don't want this or
      -- prefer not to change your tasklist.lua remove the following line!
      { hide_icon = true })
  end, mytasklist.buttons)


  -- Here we create the wiboxes if it's not a dual-screen layout
  if screencount ~= 2 then
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 20 })
    mywibox[s].widgets = {
      {
        space, mytaglist[s],
        spacer, mypromptbox[s],
        layout = awful.widget.layout.horizontal.leftright
      },

      spacer, mytextclock,
      space, mylayoutbox[s],
      spacer, mysystray,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
    }

    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, height = 20 })
  end
end

if screencount == 2 then
  -- Here we create the wiboxes if it is a dual screen configuration:
  mywibox[1] = awful.wibox({ position = "top", screen = 1, border_width = 0, height = 20 })
  mywibox[1].widgets = {
    {
      space, mytaglist[1],
      spacer, mypromptbox[1],
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer, mytextclock,
    space, mylayoutbox[1],
    spacer, mytasklist[1],
    layout = awful.widget.layout.horizontal.rightleft
  }

  mybottomwibox[1] = awful.wibox({ position = "bottom", screen = 1, border_width = 0, height = 20 })

  mybottomwibox[1].widgets = {
    {
      spacer,
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer, mysystray,
    layout = awful.widget.layout.horizontal.rightleft
  }
  mywibox[2] = awful.wibox({ position = "top", screen = 2, border_width = 0, height = 20 })

  mywibox[2].widgets = {
    {
      space, mytaglist[2],
      spacer, mypromptbox[2],
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer, mytextclock,
    space, mylayoutbox[2],
    spacer, mytasklist[2],
    layout = awful.widget.layout.horizontal.rightleft
  }

  mybottomwibox[2] = awful.wibox({ position = "bottom", screen = 2, border_width = 0, height = 20 })
end

-- Mouse bindings
root.buttons(awful.util.table.join(awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)))

-- Key bindings
globalkeys = awful.util.table.join(awful.key({ modkey, }, "Left", awful.tag.viewprev),
  awful.key({ modkey, }, "Right", awful.tag.viewnext),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore),

  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "w", function() mymainmenu:show({ keygrabber = true }) end),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift" }, "q", awesome.quit),

  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1) end),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),
  awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),

  -- Prompt
  awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end),

  -- Lock screen
  awful.key({ modkey }, "F1", function () awful.util.spawn("slock") end),

  awful.key({ modkey }, "x",
    function()
      awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end))

clientkeys = awful.util.table.join(awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey, }, "o", awful.client.movetoscreen),
  awful.key({ modkey, "Shift" }, "r", function(c) c:redraw() end),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),
  awful.key({ modkey, }, "n", function(c) c.minimized = not c.minimized end),
  awful.key({ modkey, }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical = not c.maximized_vertical
    end))

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screencount do
  keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewonly(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.movetotag(tags[client.focus.screen][i])
        end
      end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.toggletag(tags[client.focus.screen][i])
        end
      end))
end

clientbuttons = awful.util.table.join(awful.button({}, 1, function(c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      size_hints_honor = false,
      focus = true,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
  {
    rule = { class = "pidgin" },
    properties = {
      tag = tags[1][4]
    }
  },
  {
    rule = { class = "gimp" },
    properties = {
      floating = true
    }
  },
  {
    rule = { class = "Firefox" },
    properties = {
      tag = tags[1][1]
    }
  },
  {
    rule = { class = "Chromium" },
    properties = {
      tag = tags[1][3]
    }
  },
  {
    rule = { class = "Google Chrome" },
    properties = {
      tag = tags[1][1]
    }
  }
}

-- Signal function to execute when a new client appears.
client.add_signal("manage", function(c, startup)
-- Enable sloppy focus
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end
end)

awful.util.spawn("wmname \"LG3D\"")
awful.util.spawn_with_shell("/home/pothix/.dotbin/dzen-tools/bin/systat2dzen | env dzen2_height=20 /home/pothix/.dotbin/dzen-tools/bin/run_dzen2_bottom -xs 2 -fn \"terminus-9\"")
