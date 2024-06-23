{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      presets = {
        command_palette = false;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = true;
      };
    };
  };
}
