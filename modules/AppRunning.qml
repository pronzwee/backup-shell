import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.config

PanelWindow {
    id: root

    property int barHeight: 130
    property int barWidth: 1000
    property bool isOpen: false

    anchors.bottom: true
    exclusiveZone: 0
    implicitHeight: barHeight
    implicitWidth: barWidth
    WlrLayershell.layer: "Overlay"

    color: "transparent"

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    mask: Region { item: row }

    RowLayout {
        id: row

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
        y: isOpen ? (parent.height - (barHeight - 20)) : parent.height
        Behavior on y {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }

        Rectangle {
            Layout.alignment: Qt.AlignBottom
            width: 20
            height: 20
            color: Theme.trans

            Curve {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                isTop: false
                mirrored: true
                radius: 18
            }
        }

        Rectangle {
            id: content

            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: 700
            Layout.preferredHeight: 110

            color: Theme.bg
            topLeftRadius: 22
            topRightRadius: 22
            clip: true

            WallpaperPicker {
                id: wallpaperPicker
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignBottom
            width: 20
            height: 20
            color: Theme.trans

            Curve {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                isTop: false
                mirrored: false
                radius: 18
            }
        }

        IpcHandler {
            target: "wallpaper"
            function toggle(): void {
                isOpen = !isOpen
            }
        }
    }
}
