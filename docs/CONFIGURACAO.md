# Configuração e instalação

## Base necessária

Este conjunto acompanha uma instalação Arch Linux com Hyprland 0.56+, HyDE e sessão Wayland funcional. A configuração pessoal atual é Lua e carrega `~/.config/hypr/hyprland.lua` pelo entrypoint `~/.local/share/hypr/hyde.lua` do HyDE. O repositório inclui só a camada pessoal e não contém esse entrypoint nem os módulos do HyDE.

Pacotes usados diretamente: `hyprland`, `waybar`, `rofi`, `kitty`, `quickshell`, `cava`, `fastfetch`, `dunst`, `wlogout`, `hypridle`, `hyprlock`, `hyprpaper`, `grim`, `hyprshot`, `playerctl`, `pavucontrol`, `network-manager-applet`, `bluez-utils`, `ttf-cascadia-code-nerd`, `noto-fonts-emoji`.

O botão de energia e o menu associado usam `hyde-shell`, `hyde` e os módulos/menu XML do HyDE. `blueman-manager` depende do applet Bluetooth instalado; rede depende de NetworkManager. Se você não usa um destes recursos, remova ou altere o botão correspondente no Quickshell antes de ativar o serviço.

## O que o instalador altera

Ele copia somente os alvos que estão nesta árvore: configuração pessoal Hyprland, layout e CSS Waybar, configuração Rofi, tema do Kitty, Fastfetch, Cava, GTK 3/4, Qt5ct/Qt6ct, Kvantum, wlogout, wallpaper e unidade de serviço Quickshell. Antes de sobrescrever um alvo existente, move o arquivo/diretório antigo para `~/.local/state/bloody-carmine-backups/<data-hora>/` preservando seu caminho relativo.

O serviço Quickshell fica instalado, mas desabilitado. A unidade usa `%h` em vez de caminho absoluto. Após revisar e testar os caminhos chamados pelo seu sistema, habilite manualmente:

```bash
systemctl --user enable --now bloody-control.service
```

Para desfazer, restaure o backup mais recente de `~/.local/state/bloody-carmine-backups/`. Não há rollback automático: isso evita substituir silenciosamente trabalho que você tenha feito depois da instalação.

## Adaptação de outro sistema

1. Faça backup externo dos seus arquivos e leia o diff do script antes de executar.
2. Instale Arch, Hyprland e HyDE segundo a documentação upstream. Abra uma sessão e confirme `hyprctl version` e `hyde-shell`.
3. Instale as dependências da lista acima que quiser usar. Confirme o nome da fonte Nerd Font escolhida; troque `CaskaydiaCove Nerd Font` no CSS se usar outra.
4. Clone este repositório e execute `./install.sh` como seu usuário normal.
5. Confirme no seu entrypoint HyDE que a configuração pessoal Lua é carregada. Mescle as opções relevantes do `hypr/hyprland.lua` com sua configuração em vez de substituir o entrypoint do HyDE.
6. Escolha o layout Carmine com `hyde-shell waybar --set bloody-carmine` se essa interface estiver disponível na versão instalada. O layout e CSS foram guardados nos diretórios pessoais do Waybar usados pelo HyDE.
7. Revise `~/.config/hypr/hyprpaper.conf` ou o mecanismo de wallpaper da sua instalação e defina o arquivo em `~/Pictures/wallpapers/bloody-carmine.png`.
8. Abra um terminal e rode `fastfetch`; valide Waybar, Rofi, notificações, atalhos e lock screen antes de usar a sessão como principal.
9. Se tudo estiver correto, habilite o serviço Quickshell opcional.

## Notas do sistema de origem

- Arch Linux x86_64, Hyprland em Wayland, HyDE com Lua, monitor 1920×1080.
- Waybar usa módulos externos de energia do HyDE.
- O controle de mídia conversa via MPRIS com `playerctl`; o centro de controle abre pavucontrol e ferramentas de rede/Bluetooth.
- Dunst é o daemon de notificações ativo. A pasta `swaync/` existente no repositório é apenas um tema inativo e não é instalada.
- O papel de parede nesta captura é gerido também por scripts do tema local; verifique a integração no destino. O instalador coloca a imagem em `~/Pictures/wallpapers/bloody-carmine.png` e `~/.local/share/bloody-desktop/`.
- SDDM e Hyprlock contêm configuração local com limites conhecidos; não são instalados por este script.
