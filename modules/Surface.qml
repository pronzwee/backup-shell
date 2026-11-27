import Quickshell
import QtQuick

import qs.theme
import qs.components

PanelWindow {
   id: root

   property bool isOpen: false

   anchors { bottom: true }
   implicitHeight: 400
   implicitWidth: 800
   exclusiveZone: 0
   color: Colors.trans
   mask: Region { item: content }

   Rectangle {
      id: content
      anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }
      width: 500
      height: 200
      color: Colors.bg
      topLeftRadius: 20
      topRightRadius: 20
      visible: isOpen
      AppLauncher {
         launcherHeight: parent.height
         launcherWidth: parent.width
      }
   }
}