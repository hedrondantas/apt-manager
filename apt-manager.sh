#!/bin/bash

# Lista de opções
options=("Update" "Install package" "Remove package" "Clean" "Exit")
selected=0

# Função para desenhar o menu
draw_menu() {
  clear
  echo "===== MENU INTERATIVO ====="
  for i in "${!options[@]}"; do
    if [[ $i -eq $selected ]]; then
      echo -e "> \e[1;32m${options[$i]}\e[0m"  # Verde para o item selecionado
    else
      echo "  ${options[$i]}"
    fi
  done
}

# Loop de seleção
while true; do
  draw_menu
  read -rsn1 key  # Lê uma tecla (sem exibir na tela)

  if [[ $key == $'\x1b' ]]; then  # Se for uma tecla especial (seta)
    read -rsn2 key
    case $key in
      "[A")  # Seta para cima
        ((selected--))
        ((selected < 0)) && selected=$((${#options[@]} - 1))
        ;;
      "[B")  # Seta para baixo
        ((selected++))
        ((selected >= ${#options[@]})) && selected=0
        ;;
    esac
  elif [[ $key == "" ]]; then  # Enter
    clear
    echo "Você escolheu: ${options[$selected]}"
    case ${options[$selected]} in
      "Update")
        sudo apt update ;;
      "Install package")
        read -p "Digite o nome do pacote: " pkg
        sudo apt install -y "$pkg" ;;
      "Remove package")
        read -p "Digite o nome do pacote: " pkg
        sudo apt remove -y "$pkg" ;;
      "Clean")
        sudo apt autoremove -y && sudo apt clean ;;
      "Exit")
        exit 0 ;;
    esac
    read -p "Pressione Enter para voltar ao menu..."
  fi
done
