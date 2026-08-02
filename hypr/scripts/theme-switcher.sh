#!/bin/bash

# 1. Menu do Wofi para escolher o tema
THEME=$(echo -e "Gruvbox\nKoda\nOsakaJade\nTokyoNight" | wofi --dmenu --prompt "Escolha o Tema" --width 300 --height 250)

# 2. Mapeamento de variáveis e cores para cada tema
case $THEME in
    "TokyoNight")
        KITTY_THEME="tokyonight"
        NVIM_THEME="tokyonight"
        WALL_DIR="tokyonight"
        IDX_ACTIVE=1
        IDX_INACTIVE=2
        ;;
    "Gruvbox")
        KITTY_THEME="gruvbox-dh"
        NVIM_THEME="gruvbox"
        WALL_DIR="gruvbox"
        IDX_ACTIVE=3
        IDX_INACTIVE=4
        ;;
    "Koda")
        KITTY_THEME="koda"
        NVIM_THEME="koda-moss"
        WALL_DIR="koda"
        IDX_ACTIVE=5
        IDX_INACTIVE=6
        ;;
    "OsakaJade")
        KITTY_THEME="osakajade"
        NVIM_THEME="bamboo"
        WALL_DIR="osakajade"
        IDX_ACTIVE=7
        IDX_INACTIVE=8
        ;;
    *)
        exit 0
        ;;
esac

# 3. Aplicar tema no Kitty
sed -i -E "s/include .*-theme.conf/include ${KITTY_THEME}-theme.conf/g" ~/.config/kitty/kitty.conf
killall -USR1 kitty

# 4. Aplicar tema no Neovim
sed -i -E "s/vim\.cmd\.colorscheme\s+['\"].*['\"]/vim.cmd.colorscheme '${NVIM_THEME}'/g" ~/.config/nvim/lua/custom/plugins/colorscheme.lua

# 5. Salvar o tema atual para o script de Wallpaper
echo "$WALL_DIR" > ~/.cache/current_theme

# 7. Mudar para um wallpaper aleatório da pasta do tema
WALL_DIR_FULL="$HOME/Pictures/Wallpapers/$WALL_DIR"

# Garante que o awww-daemon está rodando
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 1
fi

RANDOM_WALL=$(find "$WALL_DIR_FULL" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

if [ -n "$RANDOM_WALL" ]; then
    awww img "$RANDOM_WALL" \
        --transition-type grow \
        --transition-step 90 \
        --transition-fps 60
fi

hyprctl eval "hl.dispatch(hl.dsp.exec_cmd(\"hyprctl --batch 'keyword general:col.active_border $ACTIVE_BORDER ; keyword general:col.inactive_border $INACTIVE_BORDER'\"))"

sed -i -E "s/active_border\s*=\s*borda\[[0-9]+\]/active_border   = borda[${IDX_ACTIVE}]/g" ~/dotfiles/hypr/hyprland.lua
sed -i -E "s/inactive_border\s*=\s*borda\[[0-9]+\]/inactive_border = borda[${IDX_INACTIVE}]/g" ~/dotfiles/hypr/hyprland.lua
