import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.components

ShellRoot {
   id: root

   property int barH: Theme.barHeight
   property int barW: Theme.barWidth

   Variants {
      model: Quickshell.screens
      delegate: PanelWindow {
         required property var modelData

         anchors.top: true
         implicitHeight: barH
         implicitWidth: barW
         exclusiveZone: 40
         color: Colors.trans
         mask: Region { item: island }

         Rectangle {
            id: island
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 8
            width: barW - 30
            height: 37
            radius: barH / 2
            color: Colors.bg
            Pill {
               anchors.horizontalCenter: parent.horizontalCenter
               Text {
                  y: 4
                  text: Qt.formatDateTime(Clock.date, "hh : mm")
                  color: "white"
                  font {
                     family: "SF Pro Display"
                     weight: Font.Medium + 50
                     pixelSize: 14
                  }
               }
            }
         }
      }
   }
}