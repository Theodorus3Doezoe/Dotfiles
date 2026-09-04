if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx SUDO_EDITOR nvim

    # Aliases
    alias vim="nvim"
    alias vi="nvim"
    alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME'

    # Voorkom sudo nvim, gebruik sudoedit
    function sudo
        if test "$argv[1]" = nvim
            command sudoedit $argv[2..-1]
        else
            command sudo $argv
        end
    end

    set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
    fastfetch
    starship init fish | source
    fzf_key_bindings

    # fzf theme based on Hyprland colors
    set -gx FZF_DEFAULT_OPTS " \
    --color=bg+:#1a1a1a,bg:-1,spinner:#00ff99,hl:#33ccff \
    --color=fg:#cdd6f4,header:#33ccff,info:#00ff99,pointer:#33ccff \
    --color=marker:#00ff99,fg+:#ffffff,prompt:#00ff99,hl+:#33ccff"
end

# Functie om de GPU te activeren en drivers te installeren
function gpu-on
    echo "PCI-verwijder regel deactiveren..."
    if test -f /etc/udev/rules.d/00-remove-nvidia.rules
        sudo mv /etc/udev/rules.d/00-remove-nvidia.rules /etc/udev/rules.d/00-remove-nvidia.rules.bak
    end

    echo "Bezig met installeren van NVIDIA drivers (dit kan even duren)..."
    sudo pacman -S --needed nvidia-580xx-dkms nvidia-580xx-utils nvidia-580xx-settings opencl-nvidia-580xx lib32-nvidia-580xx-utils lib32-opencl-nvidia-580xx cuda

    echo "Klaar! Herstart je laptop om de dGPU te gebruiken."
end

zoxide init fish | source

# Yazi shell integration: type 'y' to open yazi and cd on exit
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Added by qodercli install
fish_add_path $HOME/.local/bin

set -x OPENAI_API_BASE "http://localhost:20128/v1"
set -x OPENAI_API_KEY sk-4cce50c8d123e043-79ba36-0da1ef49

# Added by codebase-memory-mcp install
fish_add_path /home/sven/.local/bin

function wake
    systemd-inhibit --what=sleep --why="Terminal actief" --mode=block sleep infinity
end
