{
  programs.nixvim = {
    plugins = {
      notify = {
        enable = true;
        backgroundColour = "#000000";
        fps = 20;
        timeout = 2000;
      };
    };

    extraConfigLuaPost = ''
      local banned_messages = { "No information available" }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require("notify")(msg, ...)
      end
    '';
  };
}
