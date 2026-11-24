import Quickshell
import QtQuick

import qs.theme
import qs.config

PanelWindow {
   id: win

   property string edge: "left"
   readonly property bool isRight: edge === "right"
   property real curveRadius: 25

   anchors {
      top: true
      bottom: true
      left: !win.isRight
      right: win.isRight
   }

   exclusionMode: "Ignore"
   implicitWidth: win.curveRadius
   color: Colors.trans

   Curve {
      anchors {
         top: parent.top
         left: !win.isRight ? parent.left : undefined
         right: win.isRight ? parent.right : undefined
      }
      mirrored: win.isRight
      isTop: true
      radius: win.curveRadius
   }

   Curve {
      anchors {
         bottom: parent.bottom
         left: !win.isRight ? parent.left : undefined
         right: win.isRight ? parent.right : undefined
      }
      mirrored: win.isRight
      isTop: false
      radius: win.curveRadius
   }
}