#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="${XDG_STATE_HOME:-$HOME/.local/state}/bloody-carmine-backups/$STAMP"

targets=(
  "hypr/hyprland.lua:.config/hypr/hyprland.lua"
  "hypr/execs.lua:.config/hypr/execs.lua"
  "hypr/hypridle.conf:.config/hypr/hypridle.conf"
  "waybar/layouts/bloody-carmine.jsonc:.config/waybar/layouts/bloody-carmine.jsonc"
  "waybar/styles/bloody-carmine.css:.config/waybar/styles/bloody-carmine.css"
  "rofi/config.rasi:.config/rofi/config.rasi"
  "rofi/theme.rasi:.config/rofi/theme.rasi"
  "kitty/bloody.conf:.config/kitty/bloody.conf"
  "fastfetch/config.jsonc:.config/fastfetch/config.jsonc"
  "fastfetch/logo/bloody.txt:.config/fastfetch/logo/bloody.txt"
  "wallpaper/bloody-carmine.png:.local/share/bloody-desktop/raven-flying-sharingan-red-moon.png"
  "cava/config:.config/cava/config"
  "gtk/gtk-3.0/settings.ini:.config/gtk-3.0/settings.ini"
  "gtk/gtk-4.0/settings.ini:.config/gtk-4.0/settings.ini"
  "qt/qt5ct/qt5ct.conf:.config/qt5ct/qt5ct.conf"
  "qt/qt5ct/colors/wallbash.conf:.config/qt5ct/colors/wallbash.conf"
  "qt/qt6ct/qt6ct.conf:.config/qt6ct/qt6ct.conf"
  "qt/qt6ct/colors/wallbash.conf:.config/qt6ct/colors/wallbash.conf"
  "kvantum/kvantum.kvconfig:.config/Kvantum/kvantum.kvconfig"
  "kvantum/wallbash:.config/Kvantum/wallbash"
  "waybar/modules/custom-power.jsonc:.local/share/waybar/modules/custom-power.jsonc"
  "wlogout:.config/wlogout"
  "wallpaper/bloody-carmine.png:Pictures/wallpapers/bloody-carmine.png"
  "spicetify/visualizer:.config/spicetify/CustomApps/visualizer"
  "quickshell/bloody-control:.config/quickshell/bloody-control"
)

mkdir -p "$BACKUP"
for entry in "${targets[@]}"; do
  src="${entry%%:*}"
  rel="${entry#*:}"
  [[ -e "$ROOT/$src" ]] || { printf 'Arquivo ausente: %s\n' "$src" >&2; exit 1; }
  dest="$HOME/$rel"
  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP/$(dirname -- "$rel")"
    mv -- "$dest" "$BACKUP/$rel"
  fi
  mkdir -p "$(dirname -- "$dest")"
  cp -a -- "$ROOT/$src" "$dest"
done

if command -v spicetify >/dev/null 2>&1; then
  spicetify config custom_apps 'marketplace|visualizer'
  spicetify apply
else
  printf 'Spicetify não encontrado; arquivos da Custom App foram copiados, mas não ativados.
' >&2
fi

mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0" "$HOME/.local/share/themes"
if [[ -e "$HOME/.local/share/themes/Bloody-Carmine" || -L "$HOME/.local/share/themes/Bloody-Carmine" ]]; then
  mkdir -p "$BACKUP/.local/share/themes"
  mv -- "$HOME/.local/share/themes/Bloody-Carmine" "$BACKUP/.local/share/themes/Bloody-Carmine"
fi
cp -a -- "$ROOT/gtk/Bloody-Carmine" "$HOME/.local/share/themes/Bloody-Carmine"
for gtk_version in 3.0 4.0; do
  gtk_file="$HOME/.config/gtk-$gtk_version/gtk.css"
  if [[ -e "$gtk_file" || -L "$gtk_file" ]]; then
    mkdir -p "$BACKUP/.config/gtk-$gtk_version"
    mv -- "$gtk_file" "$BACKUP/.config/gtk-$gtk_version/gtk.css"
  fi
  ln -s "$HOME/.local/share/themes/Bloody-Carmine/gtk-$gtk_version/gtk.css" "$gtk_file"
done


unit="$HOME/.config/quickshell/bloody-control/bloody-control.service"
sed -i 's|/home/[^/]*/.config/quickshell/bloody-control|%h/.config/quickshell/bloody-control|' "$unit"
mkdir -p "$HOME/.config/systemd/user"
cp -a -- "$unit" "$HOME/.config/systemd/user/bloody-control.service"
systemctl --user daemon-reload

printf 'Instalado. Backup anterior em: %s\n' "$BACKUP"
printf 'Revise docs/CONFIGURACAO.md. O serviço Quickshell permanece desabilitado.\n'
