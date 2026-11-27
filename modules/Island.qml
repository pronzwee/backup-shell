import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.theme
import qs.components
import qs.config
import qs.config.cava
import qs.services

ShellRoot {
   id: root

   readonly property bool isPlayinng: Cava.total !== 0
   property bool visualizerShown: false
   property int barH: Theme.barHeight
   property int barW: Theme.barWidth

   Timer {
      interval: 1000
      repeat: false
      running: !isPlayinng   
      onTriggered: visualizerShown = false
   }

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
            }
         }
      }
   }
}