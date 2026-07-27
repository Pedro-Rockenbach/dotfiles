#!/bin/bash

# Defina o caminho exato da pasta onde estão os wallpapers
PASTA="$HOME/Pictures/Wallpapers"

# Encontra todas as imagens na pasta e escolhe uma aleatoriamente
IMAGEM=$(find "$PASTA" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)

# Verifica se a pasta tem imagens para evitar erros
if [ -z "$IMAGEM" ]; then
    echo "Nenhuma imagem encontrada em: $PASTA"
    exit 1
fi

# Lista de transições legais do swww
TRANSICOES=("grow" "wipe" "wave" "outer" "center")

# Escolhe uma transição aleatória da lista acima
TRANSICAO=${TRANSICOES[$RANDOM % ${#TRANSICOES[@]}]}

# Aplica o wallpaper
awww img "$IMAGEM" \
    --transition-type "$TRANSICAO" \
    --transition-step 90 \
    --transition-fps 60
