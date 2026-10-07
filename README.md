# Bloody Carmine — dotfiles locais

Recorte organizado da configuração atual para revisão e eventual compartilhamento. **Este diretório é local; nada foi publicado ou enviado a um remoto.**

## Conteúdo

- Waybar Carmine e painel Quickshell de controles rápidos.
- Estilos do wlogout e rascunho de tema SwayNC.
- Ajustes GTK, paletas Qt/Kvantum, Rofi e Kitty.

## Antes de instalar em outra máquina

1. Confira as dependências: Hyprland, Waybar, Quickshell, Dunst, wlogout, Rofi, GTK, qt5ct/qt6ct e Kvantum; os botões de áudio/rede/Bluetooth chamam pavucontrol, nm-connection-editor e blueman-manager.
2. Substitua caminhos pessoais /home/bloody e confira módulos externos do HyDE antes de copiar os arquivos.
3. Instale fontes e ícones compatíveis com os nomes configurados ou troque-os pelos disponíveis no destino.
4. O SwayNC está apenas tematizado aqui; a sessão atual continua usando Dunst, pois ambos disputam o serviço D-Bus de notificações.
5. O wallpaper e arquivos de bloqueio foram excluídos intencionalmente; configure os caminhos e valide o Hyprlock antes de ativá-los.
6. Verifique as licenças originais dos temas GTK/Kvantum e dos arquivos derivados antes de redistribuí-los.

## Atalhos

O ícone de engrenagem na Waybar abre o centro de controle Carmine. A janela oferece áudio, conexões, Bluetooth, alternância de Não Perturbe, recuperação da notificação dispensada mais recente e o menu existente de energia/sessão.

A paleta GTK vem da cópia Bloody-Carmine do Graphite-Mono incluída em gtk-theme/Bloody-Carmine. Os arquivos de cor qt5ct/qt6ct estão nomeados wallbash.conf para corresponder às configurações incluídas. Essa seleção conserva caminhos locais em alguns arquivos; adapte antes de instalar fora desta máquina.
