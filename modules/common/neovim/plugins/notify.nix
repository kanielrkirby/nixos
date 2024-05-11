{
  programs.nixvim = {
    plugins = {
      notify = {
        enable = false;
        backgroundColour = "#000000";
        fps = 20;
        timeout = 0;
      };
    };

    extraConfigLuaPost = ''
      vim.notify = function(msg, ...)
        for _, banned in ipairs({ "No information available" }) do
          if msg == banned then
            return
          end
        end
        return require("notify")(msg, ...)
      end
    '';
  };
}
