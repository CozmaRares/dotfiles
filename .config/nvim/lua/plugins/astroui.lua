---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "tokyonight",
    highlights = {
      init = {
        Comment = { italic = true, fg = "#ffd700" },
        ["@comment"] = { italic = true, fg = "#ffd700" },

        -- transparent bg
        -- NormalFloat = { bg = "NONE", ctermbg = "NONE" },
        -- Normal = { bg = "NONE", ctermbg = "NONE" },
        -- Folded = { bg = "NONE", ctermbg = "NONE" },
        -- TelescopeNormal = { bg = "NONE", ctermbg = "NONE" },
        -- TelescopePrompt = { bg = "NONE", ctermbg = "NONE" },
        -- TelescopeResults = { bg = "NONE", ctermbg = "NONE" },
        -- TelescopePromptNormal = { bg = "NONE", ctermbg = "NONE" },
        -- TelescopePromptPrefix = { bg = "NONE", ctermbg = "NONE" },
        -- CursorLine = { bg = "NONE", ctermbg = "NONE" },
        -- Pmenu = { bg = "NONE", ctermbg = "NONE" },
        -- 
        -- Normal = { bg = "NONE", ctermbg = "NONE" },
        -- Float = { bg = "NONE", ctermbg = "NONE" },
        -- NormalNC = { bg = "NONE", ctermbg = "NONE" },
        -- NormalFloat = { bg = "NONE", ctermbg = "NONE" },
        -- CursorColumn = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
        -- CursorLineNr = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
        -- CursorLineFold = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
        -- LineNr = {},
        -- SignColumn = {},
        -- StatusLine = {},
        -- NeoTreeNormal = { bg = "NONE", ctermbg = "NONE" },
        -- NeoTreeNormalNC = { bg = "NONE", ctermbg = "NONE" },
        -- TabLineFill = { bg = "NONE", ctermbg = "NONE" },
      },
    },
    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
