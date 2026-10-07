import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
    id: root
    property bool opened: false

    Process { id: audio; running: false; command: ["pavucontrol"] }
    Process { id: network; running: false; command: ["nm-connection-editor"] }
    Process { id: bluetooth; running: false; command: ["blueman-manager"] }
    Process { id: power; running: false; command: ["hyde-shell", "logoutlaunch"] }
    Process { id: dnd; running: false; command: ["dunstctl", "set-paused", "toggle"] }
    Process { id: history; running: false; command: ["dunstctl", "history-pop"] }

    PanelWindow {
        id: panel
        visible: root.opened
        anchors { top: true; right: true }
        margins { top: 44; right: 12 }
        implicitWidth: 350
        implicitHeight: 470
        exclusiveZone: 0
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "bloody-control"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

        Rectangle {
            anchors.fill: parent
            color: "#101115"
            radius: 10
            border.width: 1
            border.color: "#753142"
            focus: true
            Keys.onEscapePressed: root.opened = false

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 9

                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        text: "CENTRO DE CONTROLE"
                        color: "#d75b6e"
                        font.family: "CaskaydiaCove Nerd Font"
                        font.pixelSize: 12
                        font.letterSpacing: 1
                    }
                    Item { Layout.fillWidth: true }
                    Rectangle {
                        implicitWidth: 28; implicitHeight: 28; radius: 5
                        color: closeMouse.containsMouse ? "#29232b" : "transparent"
                        Text { anchors.centerIn: parent; text: "󰅖"; color: "#e8e4de"; font.pixelSize: 16 }
                        MouseArea { id: closeMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.opened = false }
                    }
                }

                Text {
                    text: "ATALHOS DO SISTEMA"
                    color: "#aaa5ad"
                    font.family: "CaskaydiaCove Nerd Font"
                    font.pixelSize: 10
                    font.letterSpacing: 1
                    Layout.topMargin: 5
                }

                ActionRow { icon: "󰕾"; title: "Áudio"; detail: "Volume e dispositivos"; onTriggered: audio.running = true }
                ActionRow { icon: "󰖩"; title: "Rede"; detail: "Wi-Fi e conexões"; onTriggered: network.running = true }
                ActionRow { icon: "󰂯"; title: "Bluetooth"; detail: "Dispositivos pareados"; onTriggered: bluetooth.running = true }

                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#35353f"; Layout.topMargin: 3; Layout.bottomMargin: 3 }

                Text {
                    text: "NOTIFICAÇÕES E SESSÃO"
                    color: "#aaa5ad"
                    font.family: "CaskaydiaCove Nerd Font"
                    font.pixelSize: 10
                    font.letterSpacing: 1
                }
                ActionRow { icon: "󰂛"; title: "Não perturbe"; detail: "Alternar notificações temporárias"; onTriggered: dnd.running = true }
                ActionRow { icon: "󰎟"; title: "Ver notificação anterior"; detail: "Recuperar o último aviso dispensado"; onTriggered: history.running = true }
                ActionRow { icon: "󰐥"; title: "Energia e sessão"; detail: "Bloquear, sair, reiniciar ou desligar"; onTriggered: power.running = true }

                Item { Layout.fillHeight: true }
                Text { text: "BLOODY  ·  CARMINE"; color: "#5d5962"; font.family: "CaskaydiaCove Nerd Font"; font.pixelSize: 9; Layout.alignment: Qt.AlignRight }
            }
        }
    }

    component ActionRow: Rectangle {
        id: row
        property string icon
        property string title
        property string detail
        signal triggered
        Layout.fillWidth: true
        Layout.preferredHeight: 47
        radius: 7
        color: actionMouse.containsMouse ? "#23232b" : "#19191f"
        border.width: 1
        border.color: actionMouse.containsMouse ? "#922d40" : "#35353f"
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 11
            Text { text: row.icon; color: "#d75b6e"; font.family: "CaskaydiaCove Nerd Font"; font.pixelSize: 17 }
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 1
                Text { text: row.title; color: "#e8e4de"; font.family: "Cantarell"; font.pixelSize: 12; font.bold: true }
                Text { text: row.detail; color: "#aaa5ad"; font.family: "Cantarell"; font.pixelSize: 10; elide: Text.ElideRight; Layout.fillWidth: true }
            }
            Text { text: "›"; color: "#753142"; font.pixelSize: 20 }
        }
        MouseArea { id: actionMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: row.triggered() }
    }

    IpcHandler {
        target: "control"
        function toggle(): void { root.opened = !root.opened }
        function open(): void { root.opened = true }
        function close(): void { root.opened = false }
    }
}
