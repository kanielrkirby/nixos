{ config, username, pkgs, ... }:

{
  sops.secrets."openai.com/sk" = { };

#   system.activationScripts.setup-mods.text = ''
# source ${config.system.build.setEnvironment}
# mkdir -p /home/${username}/.config/mods
# 
# cat << EOF > /home/${username}/.config/mods/mods.yml
# # Default model (gpt-3.5-turbo, gpt-4, ggml-gpt4all-j...).
# default-model: gpt-4
# # Text to append when using the -f flag.
# format-text:
#   markdown: 'Format the response as markdown without enclosing backticks.'
#   json: 'Format the response as json without enclosing backticks.'
# # List of predefined system messages that can be used as roles.
# roles:
#   "default": []
# # Ask for the response to be formatted as markdown unless otherwise set.
# format: false
# # System role to use.
# role: "default"
# # Render output as raw text when connected to a TTY.
# raw: false
# # Quiet mode (hide the spinner while loading and stderr messages for success).
# quiet: false
# # Temperature (randomness) of results, from 0.0 to 2.0.
# temp: 1.0
# # TopP, an alternative to temperature that narrows response, from 0.0 to 1.0.
# topp: 1.0
# # Turn off the client-side limit on the size of the input into the model.
# no-limit: false
# # Wrap formatted output at specific width (default is 80)
# word-wrap: 80
# # Include the prompt from the arguments in the response.
# include-prompt-args: false
# # Include the prompt from the arguments and stdin, truncate stdin to specified number of lines.
# include-prompt: 0
# # Maximum number of times to retry API calls.
# max-retries: 5
# # Your desired level of fanciness.
# fanciness: 10
# # Text to show while generating.
# status-text: Generating
# # Default character limit on input to model.
# max-input-chars: 12250
# # Maximum number of tokens in response.
# # max-tokens: 100
# # Aliases and endpoints for OpenAI compatible REST API.
# apis:
#   openai:
#     base-url: https://api.openai.com/v1
#     api-key: '$(cat ${config.sops.secrets."openai.com/sk".path})'
#     api-key-env: OPENAI_API_KEY
#     models:
#       gpt-4:
#         aliases: ["4"]
#         max-input-chars: 24500
#         fallback: gpt-3.5-turbo
#       gpt-4-1106-preview:
#         aliases: ["128k"]
#         max-input-chars: 392000
#         fallback: gpt-4
#       gpt-4-32k:
#         aliases: ["32k"]
#         max-input-chars: 98000
#         fallback: gpt-4
#       gpt-3.5-turbo:
#         aliases: ["35t"]
#         max-input-chars: 12250
#         fallback: gpt-3.5
#       gpt-3.5-turbo-1106:
#         aliases: ["35t-1106"]
#         max-input-chars: 12250
#         fallback: gpt-3.5-turbo
#       gpt-3.5-turbo-16k:
#         aliases: ["35t16k"]
#         max-input-chars: 44500
#         fallback: gpt-3.5
#       gpt-3.5:
#         aliases: ["35"]
#         max-input-chars: 12250
#         fallback:
#   groq:
#     base-url: https://api.groq.com/openai/v1
#     api-key-env: GROQ_API_KEY
#     models:
#       mixtral-8x7b-32768:
#         aliases: ["mixtral"]
#         max-input-chars: 98000
#       llama2-70b-4096:
#         aliases: ["llama2"]
#         max-input-chars: 12250
#   localai:
#     # LocalAI setup instructions: https://github.com/go-skynet/LocalAI#example-use-gpt4all-j-model
#     base-url: http://localhost:8080
#     models:
#       ggml-gpt4all-j:
#         aliases: ["local", "4all"]
#         max-input-chars: 12250
#         fallback:
#   azure:
#     # Set to 'azure-ad' to use Active Directory
#     # Azure OpenAI setup: https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/create-resource
#     base-url: https://YOUR_RESOURCE_NAME.openai.azure.com
#     api-key:
#     api-key-env: AZURE_OPENAI_KEY
#     models:
#       gpt-4:
#         aliases: ["az4"]
#         max-input-chars: 24500
#         fallback: gpt-35-turbo
#       gpt-35-turbo:
#         aliases: ["az35t"]
#         max-input-chars: 12250
#         fallback: gpt-35
#       gpt-35:
#         aliases: ["az35"]
#         max-input-chars: 12250
#         fallback:
# EOF
#   '';

  home-manager.users."${username}" = {
    home.packages = with pkgs; [ mods ]; 
    programs.zsh.initExtra = ''
    np() {
      __path="/tmp/__np_mods.txt"
      __model="gpt-3.5-turbo"

      for arg in "$@"; do
        case $arg in
          -m) 
            if [ -z "$2" ]; then
              echo "Error: No model passed to np, but flag `-m` present."
              return 1
            fi
            __model="$2"
            shift; shift;
          ;;
        esac
      done

      nvim "$__path"
      if [ ! -f "$__path" ]; then
        echo "Error: No file passed to np."
        return 1
      fi

      __content="$(cat "$__path")"
      rm "$__path"

      if [ "$__content" = "" ]; then
        echo "Error: No content passed to np."
        return 1
      fi

      mods -m "$__model" "$__content"
    }
    '';

  };
}