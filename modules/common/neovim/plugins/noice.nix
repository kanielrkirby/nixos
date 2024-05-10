{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      presets = {
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = true;
      };
    };
  };
}
