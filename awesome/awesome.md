# awesome

awesome config

## Basic Settings

### Theme and Fonts

```lua
beautiful.init(gears.filesystem.get_themes_dir() .. "default/zenburn.lua")
beautiful.font = "Noto Sans 11"
beautiful.useless_gap = 3
beautiful.border_width = 0
```

### terminal and editor

```lua
terminal = "st"
editor = os.getenv("EDITOR") or "nvim"
```

### tags

hide not use tags

```lua
s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = function (t) return t.selected or #t:clients() > 0 end,
        buttons = taglist_buttons
    }
```

### disable toolbar

```lua
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
```

### make defalut layout as tile

```lua
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[2])
```

### bottom wibar

`s.mywibox = awful.wibar({ position = "bottom", screen = s })`
