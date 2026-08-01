#!/bin/bash

# Lê qual o tema atual definido pelo theme-switcher.
# Se o arquivo não existir, usa uma pasta padrão (ex: tokyonight).
if [ -f "$HOME/.cache/current_theme" ]; then
    CURRENT_THEME=$(cat "$HOME/.cache/current_theme")
else
    CURRENT_THEME="tokyonight"
fi

# Configurações de diretórios (agora apontando para a subpasta do tema)
WALL_DIR="$HOME/Pictures/Wallpapers/$CURRENT_THEME"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs/$CURRENT_THEME"

mkdir -p "$CACHE_DIR"

# 1. Gera miniaturas no cache (se ainda não existirem)
find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r img; do
    hash=$(echo "$img" | md5sum | awk '{print $1}')
    thumb="$CACHE_DIR/$hash.png"
    
    if [ ! -f "$thumb" ]; then
        magick "$img" -thumbnail 300x200^ -gravity center -extent 300x200 "$thumb"
    fi
done

# 2. Prepara a lista formatada para o Wofi (img:caminho:nome)
WOFI_INPUT=""
while read -r img; do
    hash=$(echo "$img" | md5sum | awk '{print $1}')
    thumb="$CACHE_DIR/$hash.png"
    filename=$(basename "$img")
    
    # Sintaxe do Wofi para exibir ícone/imagem
    WOFI_INPUT+="img:$thumb:text:$filename\n"
done < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

# 3. Abre o Wofi em modo dmenu
SELECTION=$(echo -e "$WOFI_INPUT" | wofi \
    --dmenu \
    --allow-images \
    --image-size 160 \
    --prompt "Wallpaper ($CURRENT_THEME)" \
    --width 600 \
    --height 500)

# 4. Extrai o nome do arquivo selecionado e aplica
if [ -n "$SELECTION" ]; then
    FILENAME=$(echo "$SELECTION" | awk -F ':text:' '{print $2}')
    FULL_PATH=$(find "$WALL_DIR" -type f -name "$FILENAME" | head -n 1)
    
    if [ -n "$FULL_PATH" ]; then
        # Assumindo que você quis dizer 'swww' em vez de 'awww'
        awww img "$FULL_PATH" \
            --transition-type grow \
            --transition-step 90 \
            --transition-fps 60
    fi
fi
