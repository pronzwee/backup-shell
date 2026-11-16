import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.config

PanelWindow {
    id: root

    property int barH: 600
    
    anchors { bottom: true; left: true; right: true }
    implicitHeight: barH
    exclusiveZone: 0
    color: Theme.trans
    mask: Region { item: button }
    exclusionMode: "Ignore"

    Rectangle {
        id: button
        width: 40
        height: 40
        anchors.bottom: parent.bottom
        MouseArea {
            anchors.fill: parent
            onClicked: {
                content.Layout.bottomMargin = (content.Layout.bottomMargin === 0) ? -50 : 0
            }
        }
    }

    RowLayout {
        id: layoutItem
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 0
        Rectangle {
            id: curve

            property int radius: 20
            Layout.alignment: Qt.AlignBottom
            anchors.left: parent.left
            Layout.bottomMargin: content.Layout.bottomMargin / 2
            width: radius
            height: radius
            color: Theme.trans

            Curve {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                isTop: false
                mirrored: true
                radius: curve.width
            }
        }

        Rectangle {
            id: content
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: 0
            width: 400
            height: 50
            topLeftRadius: 15
            topRightRadius: 15
            color: Theme.bg
            Behavior on Layout.bottomMargin {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignBottom
            anchors.right: parent.right
            Layout.bottomMargin: content.Layout.bottomMargin / 2
            width: curve.radius
            height: curve.radius
            color: Theme.trans

            Curve {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                isTop: false
                mirrored: false
                radius: curve.radius
            }
        }
    }
}