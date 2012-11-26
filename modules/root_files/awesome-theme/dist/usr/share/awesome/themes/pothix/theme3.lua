---------------------------
-- Default awesome theme --
---------------------------

--{{{ Main
require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/pothix"
if not awful.util.file_readable(themes .. themename .. "/theme3.lua") then
        themes = sharedthemes
end
themedir      = themes .. themename
themeicons    = themedir .. "/icons3"

wallpaper    = themedir .. "/background.jpg"
wpscript      = home .. "/.wallpaper"

theme.wallpaper_cmd = { "awsetbg -a " .. wallpaper }

theme.font          = "Liberation Sans 10"
--theme.taglist_font  = "mtx 11"
theme.taglist_font  = "ClearlyU 11"
--theme.taglist_font  = "Times 13"
--theme.taglist_bg_focus = "#252525"

theme.bottom_bg      = "#1a1a1a"
theme.bg_normal     = "#1a1a1a"
theme.bg_focus      = "#1a1a1a"
theme.bg_urgent     = "#404040"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#cccccc"
theme.fg_urgent     = "#5fa496"
theme.fg_minimize   = "#000000"
theme.bar 	    = "#6568bf"

theme.border_width  = "0"
theme.border_normal = "#30314F"
theme.border_focus  = "#3F7B6F"
theme.border_marked = "#000000"


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_fg_focus = "#CaC7B4"

-- Display the taglist squares
--theme.taglist_squares_sel   = shared .. "/themes/default/taglist/squarefw.png"
--theme.taglist_squares_unsel = shared .. "/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = themeicons .. "/layouts/tasklist/floating.png"
--theme.tasklist_floating_icon = shared .. "/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = shared .. "/themes/default/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = shared .. "/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = shared .. "/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = shared .. "/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = shared .. "/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = shared .. "/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = shared .. "/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = shared .. "/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = shared .. "/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = shared .. "/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = shared .. "/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = shared .. "/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = shared .. "/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = shared .. "/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = shared .. "/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = shared .. "/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = shared .. "/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = shared .. "/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = shared .. "/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themeicons .. "/layouts/fairh.png"
theme.layout_fairv = themeicons .. "/layouts/fairv.png"
theme.layout_floating  = themeicons .. "/layouts/floating.png"
theme.layout_magnifier = themeicons .. "/layouts/magnifier.png"
theme.layout_max = themeicons .. "/layouts/max.png"
theme.layout_fullscreen = themeicons .. "/layouts/fullscreen.png"
theme.layout_tilebottom = themeicons .. "/layouts/tilebottom.png"
theme.layout_tileleft   = themeicons .. "/layouts/tileleft.png"
theme.layout_tile = themeicons .. "/layouts/tile.png"
theme.layout_tiletop = themeicons .. "/layouts/tiletop.png"
theme.layout_spiral  = themeicons .. "/layouts/spiral.png"
theme.layout_dwindle = themeicons .. "/layouts/dwindle.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"


theme.widget_pac = themeicons .. "/pacman.png"
theme.widget_pacnew = themeicons .. "/pacman.png"

theme.widget_disk     = themeicons .. "/disk.png"
--theme.widget_ac       = themedir .. "/icons/ac.png"
--theme.widget_acblink  = themedir .. "/icons/acblink.png"
theme.widget_batfull  = themeicons .. "/bat_full_01.png"
--theme.widget_batmed   = themedir .. "/icons/batmed.png"
theme.widget_batlow   = themeicons .. "/bat_low_01.png"
theme.widget_batempty = themeicons .. "/bat_empty_01.png"
--theme.widget_vol      = themedir .. "/icons/vol.png"
--theme.widget_mute     = themedir .. "/icons/mute.png"
--theme.widget_pac      = themedir .. "/icons/pac.png"
--theme.widget_pacnew   = themedir .. "/icons/pacnew.png"
theme.widget_mail     = themeicons .. "/mail.png"
--theme.widget_mailnew  = themedir .. "/icons/mailnew.png"
theme.widget_temp     = themeicons .. "/temp.png"
theme.widget_wifi     = themeicons .. "/wifi.png"
theme.widget_mpd      = themeicons .. "/note.png"
theme.widget_cpu  = themeicons .. "/cpu.png"
theme.widget_clock  = themeicons .. "/clock.png"

theme.widget_mem      = themeicons .. "/mem.png"
theme.widget_fs       = themeicons .. "/disk.png"
theme.widget_fs2      = themeicons .. "/disk.png"
theme.widget_up       = themeicons .. "/net_up_02.png"
theme.widget_down     = themeicons .. "/net_down_02.png"


theme.widget_play      = themeicons .. "/play.png"
theme.widget_stop      = themeicons .. "/stop.png"
theme.widget_prev      = themeicons .. "/prev.png"
theme.widget_next      = themeicons .. "/next.png"

return theme
 --vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80

