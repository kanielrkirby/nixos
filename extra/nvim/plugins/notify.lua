local vim = vim

return {
  'rcarriga/nvim-notify',
  keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
        },
    },
  config = function()
    require('notify').setup {
      background_colour = "#000000",
      fps = 1,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 10,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = true
    }
    vim.notify = require('notify')
  end
}
