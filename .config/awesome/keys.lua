return {
  letter = {
    a = "a",
    b = "b",
    c = "c",
    d = "d",
    e = "e",
    f = "f",
    g = "g",
    h = "h",
    i = "i",
    j = "j",
    k = "k",
    l = "l",
    m = "m",
    n = "n",
    o = "o",
    p = "p",
    q = "q",
    r = "r",
    s = "s",
    t = "t",
    u = "u",
    v = "v",
    w = "w",
    x = "x",
    y = "y",
    z = "z",
  },

  digit = {
    zero = "0",
    one = "1",
    two = "2",
    three = "3",
    four = "4",
    five = "5",
    six = "6",
    seven = "7",
    eight = "8",
    nine = "9",
  },

  -- run `xmodmap` for more options
  mod = {
    alt = "Mod1",
    win = "Mod4",
    ctrl = "Control",
    shift = "Shift",
  },

  arrow = {
    up = "Up",
    down = "Down",
    left = "Left",
    right = "Right",
  },

  special = {
    tab = "Tab",
    esc = "Escape",
    space = "space",
    print = "Print",
    enter = "Return",
  },

  -- list of all xf86 keys in xorg
  -- https://wiki.linuxquestions.org/wiki/XF86_keyboard_symbols
  xf86 = {
    brightness = {
      up = "XF86MonBrightnessUp",
      down = "XF86MonBrightnessDown",
    },

    audio = {
      mute = "XF86AudioMute",
      volume = {
        up = "XF86AudioRaiseVolume",
        down = "XF86AudioLowerVolume",
      },
      prev = "XF86AudioPrev",
      pause = "XF86AudioPlay",
      next = "XF86AudioNext",
    },
  },

  fn = {
    f1 = "F1",
    f2 = "F2",
    f3 = "F3",
    f4 = "F4",
    f5 = "F5",
    f6 = "F6",
    f7 = "F7",
    f8 = "F8",
    f9 = "F9",
    f10 = "F10",
    f11 = "F11",
    f12 = "F12",
  },

  punct = {
    bkt = "grave",
    minus = "minus",
    equal = "equal",
    bracket_left = "bracketleft",
    bracket_right = "bracketright",
    slash = "slash",
    bkslash = "backslash",
    semi = "semicolon",
    quote = "apostrophe",
    comma = "comma",
    dot = "period",
  },
}
