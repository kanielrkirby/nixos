My (`kanielrkirby`) NixOS configuration, using [`snowfall`](https://snowfall.org/reference/lib/), for my `mac` (in the future), `wsl` (WIP), and `linux` systems.

**Note:** This project's `git` history is a little wacky, as this repo consists of several repos combined from my history of working with Nix, and I wanted to keep *some* history.

## Current Structure

As most personal Nix projects are hard to read and digest, I'd like to take a moment to guide you through the project, some of the decisions I've made, where I took bits and pieces, and just the overall structure.

### `/lib`

This is simply `nix` functions that I use in the codebase, to reduce boilerplate. It utilizes [`snowfall`](https://snowfall.org/guides/lib/library/), but only to wire things up. Some examples are `enabled = { enable = true }`, `mkOpt = type: default: description: mkOption { type = type; default = default; description = description; }`, and `capitalize` (which you can imagine the purpose yourself).

<!-- TODO: Make `/lib` more documented in comments --> 

### `/secrets`

I make use of [`sops`](https://github.com/getsops/sops) with [`sops-nix`](https://github.com/Mic92/sops-nix) for managing my personal secrets. At the moment, though, after transitioning to [`snowfall`](https://snowfall.org/reference/lib/), I broke some things. Since I don't use this extensively in `nixos` itself, I was fine leaving that until later.

The purpose of `/secrets`, though, is simply to hold my `.sops.yaml` configuration, and any others I might need.

### `/systems/{architecture}-{system}/{hostname}`

This is a [`snowfall` idiom](https://snowfall.org/guides/lib/systems/), which allows you to easily set up systems, architectures, and hostnames, all just by specifying it in the folder's name. This is one of my favorite idioms, and will continue to use this outside of `snowfall`.

I *could* have used [`/homes/{home-name}`](https://snowfall.org/guides/lib/homes/) for [`home-manager`](https://github.com/nix-community/home-manager), but I didn't like this way of managing my personal system, as many programs are [linked between `home-manager` and `nixos`]. It felt easier to simply put all configuration for both in one place. 

I make exhaustive use of my custom module, `gearshift` (though it's almost never directly referenced in `/modules`) here as well, as it simplifies setting up systems from scratch.

### `/modules/nixos`

[`/modules`](https://snowfall.org/guides/lib/modules) is the primary idiom within `snowfall`, and allows you to create your own modules extremely easily. Eventually, I'll add some `darwin` modules here, but it's more work than I'm willing to put into Nix on Mac currently.

This is separated into a few arbitrary folders. Here's the main structure though:

```
modules/nixos
├── custom
├── dms
├── fonts
├── hardware
│   ├── battery
│   ├── bluetooth
│   ├── boot
│   │   └── fs
│   │       ├── ext4
│   │       └── zfs
│   ├── brightness
│   ├── framework
│   ├── opengl
│   └── pipewire
├── network
├── nix
├── programs
│   ├── developer
│   │   ├── lazysql
│   │   ├── lsps
│   │   │   ├── bash
│   │   │   ├── csharp
│   │   │   ├── css
│   │   │   └── ...
│   │   └── virtualization
│   ├── editors
│   │   ├── helix
│   │   ├── neovim
│   │   └── vscode
│   ├── gui
│   │   ├── ark
│   │   ├── browsers
│   │   │   ├── brave
│   │   │   ├── chrome
│   │   │   ├── chromium
│   │   │   ├── firefox
│   │   │   └── tor
│   │   ├── feh
│   │   ├── foliate
│   │   └── ...
│   ├── nix
│   │   └── ...nix programs...
│   ├── security
│   │   ├── gnupg
│   │   ├── pass
│   │   ├── sops
│   │   └── ssh
│   ├── terminal
│   │   ├── emulators
│   │   ├── rice
│   │   ├── shells
│   │   └── tools
│   │       ├── age
│   │       ├── arbtt
│   │       ├── bat
│   │       └── ...
│   └── wayland
├── services
│   ├── dunst
│   ├── mullvad-vpn
│   ├── tlp
│   └── xserver
├── themes
└── wms
```

Let's go into each section!

- [`dms`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/dms): Display Managers, currently using [SDDM](https://github.com/sddm/sddm).
- [`wms`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/wms): Window Managers, currently [`hyprland`](https://github.com/hyprwm/hyprland) is the only supported one. Has custom binds and config is done in [`hypr`](https://github.com/hyprwm/hyprlang), as it seemed more flexible for my purposes.
- [`services`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/services): Things I consider service-**only**, and less program-oriented. Has [`dunst`](https://github.com/dunst-project/dunst) for notifications, [`mullvad-vpn`](https://github.com/mullvad/mullvadvpn-app/blob/main/mullvad-cli) for VPN, [`tlp`](https://github.com/linrunner/TLP) for a desperate attempt at battery life, and [`xserver`](https://gitlab.freedesktop.org/xorg), relied on by `hyprland`.
- [`hardware`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/hardware): Anything remotely hardware related. Currently with bluetooth, battery, brightness, filesystems, sound, [Framework fixes](https://wiki.archlinux.org/title/Framework_Laptop_13), and [`opengl`](https://nixos.wiki/wiki/OpenGL).
- [`network`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/network): Networking stuff, DNS (using [Mullvad](https://mullvad.net/en)), WiFI with [Network Manager](https://wiki.archlinux.org/title/NetworkManager), etc.
- [`themes`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/themes): Theming related things. Currently using the [`catppuccin` flake](https://github.com/catppuccin/nixos) and some miscellaneous [`gtk`](https://www.gtk.org/) stuff.
- [`nix`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/nix): [Nix configuration things](https://search.nixos.org/options?channel=unstable&query=nix.), some [Cachix](https://github.com/cachix/cachix).
- [`fonts`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/fonts): Font related things. Should probably be in `themes`. Currently using [`monaspice` nerd font patch](https://github.com/githubnext/monaspace) for terminal and [`noto-sans`](https://github.com/notofonts/noto-source).
- [`custom`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/custom): Contains some of my personal scripts that I've written for system stuff.

And finally, [`programs`](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs), where the bulk of the code still is.

This section is where generic programs will go. [Terminal emulators](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/terminal/emulators), [code editors](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/editors), [browsers](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/gui/browsers), etc. I try to split it up as best I can, but there's always going to be a better abstraction. 

## Defaults (that might not be default for you)

### [NuShell](https://github.com/nushell/nushell)

A [PowerShell-like](https://github.com/PowerShell/PowerShell) shell, like [`bash`](https://www.gnu.org/software/bash/) or [`zsh`](https://www.zsh.org/), with an emphasis on avoiding the sort of [string manipulation hell](https://shitcode.net/worst/language/bash) that happens in it's counterparts. Think of it as PowerShell done right.

### [Kitty](https://github.com/kovidgoyal/kitty)

A high-performance terminal emulator made in Python, C, and Go (all at once, no less!). I use this because I had micro issues with alternatives (like [`foot`](https://codeberg.org/dnkl/foot) and [`alacritty`](https://github.com/alacritty/alacritty)) that are likely fixed by now. Use what makes you happy. :) 

### [Hyprland](https://github.com/hyprwm/hyprland)

A Wayland-compositor Window Manager that seems to be miles ahead of the others. Once I have [`swhkd`](https://github.com/waycrate/swhkd) for hotkeys [on Nix](https://github.com/NixOS/nixpkgs/pull/306159), I'll be fine with any compositor though.

The reason this one matters is most of my application launching and system handling is done through keybinds, or a shell.

### [SDDM](https://github.com/sddm/sddm)

The least fuss I've had with Display Managers. Though I still have regular crashes on boot, which defeats the whole purpose. :(

### [Mullvad DNS](https://mullvad.net/en/help/dns-over-https-and-dns-over-tls) and [VPN](https://mullvad.net/en)

I use Mullvad's nameservers and VPN. You can always switch them to Google (`8.8.8.8`), Quad9 (`9.9.9.9`), or something else.

### [Catppuccin](https://github.com/catppuccin)

Catppuccin, Catppuccin, Catppuccin EVERYWHERE!!! :)

### [Helix](https://helix-editor.com)

A nice change of pace from [NeoVim](https://github.com/neovim/neovim)'s complexity, though they are missing a few good features, like `vim-fugitive`. Still the best experience I've had, with no plans to change.

I added as many of the LSPs as I could through Nix, and put them in [lsps](https://github.com/kanielrkirby/nixos/tree/master/modules/programs/developer/lsps).

## Other Niceties

### [Wayland Tools](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/wayland)

Screenshots, recording, and `ydotool`.

### [Terminal Tools](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/terminal/tools)

I default to using upgraded tools of typical Unix tools, like [`rg`](https://github.com/BurntSushi/ripgrep) instead of [`grep`](https://www.gnu.org/s/grep/manual/grep.html), [`sd`](https://github.com/chmln/sd) instead of [`sed`](https://www.gnu.org/software/sed/manual/sed.html), [`uutils/coreutils`](https://github.com/uutils/uucore) instead of [`coreutils`](https://www.gnu.org/s/coreutils/), etc.

### [Nix Helpers](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/nix)

Nix is pretty convoluted sometimes, so making use of the [awesome community](https://github.com/nix-community/awesome-nix) is really important to me.

### [Virtualization](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/developer/virtualization)

I've set up [Podman](https://github.com/containers/podman), [LibVirt](https://github.com/libvirt/libvirt), and [Vagrant](https://github.com/hashicorp/vagrant).

### [Browsers](https://github.com/kanielrkirby/nixos/tree/master/modules/nixos/programs/developer/virtualization)

I've set up [Chromium](https://www.chromium.org/) primarily, but also have [default Chrome](https://www.google.com/chrome/) [Brave](https://brave.com/), [Firefox](https://www.mozilla.org/en-US/firefox/new/), and [Tor](https://www.torproject.org/).

## General Maintenance

### Upgrade Packages

```bash
cd /etc/nixos
nix flake update
```

### Switching System

```bash
nh os switch /etc/nixos -H eclipse
```

<!-- TODO: Update the `nix` `FLAKE` environment variable to automatically infer this -->

### Switching Systems (with new inputs)

For some reason, `nh` doesn't ask for sudo for editing the `flake.lock` (at least for me), so I typically have to run the regular command every once and while.

```bash
sudo nixos-rebuild switch --flake /etc/nixos#eclipse
```

## Conclusion

This took a bit to write, so if you found this useful, think about leaving a star! But happy hacking, and I wish you the best in your Nix configurations!
