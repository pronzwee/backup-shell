import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects

import qs.services
import qs.theme
import qs.config

Rectangle {
   id: movableRect
   x: 1450
   y: 830
   width: 420
   height: 200
   radius: 25
   color: Theme.inversePrimary
   clip: true
   border.width: 2
   border.color: Theme.primary

   WaveCont {
      id: wave
      anchors.bottom: parent.bottom
      anchors.bottomMargin: -1
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      height: Cava.levels[0] ? 100 : 40
      layer.enabled: true
      layer.effect: OpacityMask {
         maskSource: Rectangle {
            width: wave.width
            height: wave.height
            radius: 25
         }
      }
   }
   Resources {
      id: resource
   }

   Rectangle {
      anchors { top: parent.top; left: parent.left; leftMargin: 28; topMargin: 20 }
      width: 160
      height: 160
      color: Theme.trans
      y: 12

      CavaRing {
         anchors.centerIn: parent
         count: 55
         barWidth: 6
         innerRadius: 73
         maxBar: 27
         z: 1
      }

      Rectangle {
         id: rRect
         anchors { top: parent.top; right: parent.right; margins: 10 }
         width: 10
         height: 80
         radius: 10
         z: 1
         rotation: 14
      }

      Rectangle {
         width: 12
         height: 15
         radius: 20
         color: Theme.surface
         anchors.top: rRect.bottom
         anchors.right: rRect.left 
         anchors.topMargin: -9
         anchors.rightMargin: -2
         z: 2
         rotation: 13
      }

      Rectangle {
         id: imgRect
         anchors.centerIn: parent
         width: img.width + 10
         height: img.height + 10
         radius: img.width
         clip: true
         color: Theme.primary

         RotationAnimator {
            target: imgRect
            from: 0
            to: 360
            duration: 9000
            running: true
            paused: !MprisServ.isPlaying
            loops: Animation.Infinite
         }

         Image {
            id: img
            anchors.centerIn: parent
            source: MprisServ.trackArtUrl
            width: 130
            height: 130
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true

            layer.enabled: true
            layer.effect: OpacityMask {
               maskSource: Rectangle {
                  width: img.width
                  height: img.height
                  radius: img.width / 2
               }
            }

            Rectangle {
               width: 20
               height: 20
               anchors.centerIn: parent
               radius: 20

               Rectangle {
                  width: 14
                  height: 14
                  color: Theme.surface
                  anchors.centerIn: parent
                  radius: 10
               }
            }
         }
      }
   }

   Rectangle {
      anchors { top: parent.top; right: parent.right; topMargin: 10; rightMargin: 10 }
      width: 200
      height: 178
      color: Theme.onPrimaryFixedVariant
      radius: 18

      Column {
         width: 200
         anchors { top: parent.top; left: parent.left; right: parent.right; margins: 15 }
         spacing: 5

         Text {
            text: MprisServ.trackTitle || "No media"
            width: parent.width
            font { family: "SF Pro Display"; bold: true; pixelSize: 17 }
            color: Theme.text
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
         }

         Text {
            text: MprisServ.trackArtist || "Unknown Artist"
            width: parent.width
            font { family: "SF Pro Display"; pixelSize: 13;  }
            color: Theme.text
            opacity: 0.7
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
         }

         Row {
            width: parent.width
            spacing: 10

            Rectangle {
               id: durRect1
               width: 165
               height: 4
               anchors.verticalCenter: parent.verticalCenter
               anchors.verticalCenterOffset: 50
               radius: 10
               color: Theme.text
               opacity: 1

               Rectangle {
                  id: durRect
                  anchors.verticalCenter: durRect1.verticalCenter
                  width: {
                     let dur = MprisServ.length > 0 ? MprisServ.length : 1
                     let pos = MprisServ.position
                     return Math.max(0, Math.min(parent.width, (pos / dur) * parent.width))
                  }
                  height: parent.height + 15
                  radius: 4
                  color: Theme.onPrimaryFixedVariant
                  Rectangle {
                     anchors.top: parent.top
                     anchors.right: parent.right
                     anchors.rightMargin: 4
                     width: 5
                     height: 20
                     radius: 7
                     color: Theme.primary
                  }

                  Waveform {
                     width: durRect.width - 13
                     waveColor: Theme.primary
                     frequency: 8
                     speed: 15000
                     lineWidth: 4
                     height: 12
                     y: 3
                  }
               }
            }
         }

         Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 5
            topPadding: 60

            Rectangle {
               width: 25
               height: 25
               radius: 12
               color: Theme.text
               Text {
                  text: "󰒮"
                  font.pixelSize: 16
                  color: Theme.background
                  anchors.centerIn: parent
                  MouseArea {
                     anchors.fill: parent
                     cursorShape: Qt.PointingHandCursor
                     onClicked: MprisServ.previous()
                  }
               }
            }
            Rectangle {
               width: 50
               height: 25
               radius: 6
               color: Theme.text
               Text {
                  text: MprisServ.isPlaying ? "" : ""
                  font.pixelSize: 20
                  color: Theme.background
                  anchors.centerIn: parent
                  MouseArea {
                     anchors.fill: parent
                     cursorShape: Qt.PointingHandCursor
                     onClicked: MprisServ.togglePlayPause()
                  }
               }
            }
            Rectangle {
               width: 25
               height: 25
               radius: 12
               color: Theme.text
               Text {
                  text: "󰒭"
                  font.pixelSize: 16
                  color: Theme.background
                  anchors.centerIn: parent
                  MouseArea {
                     anchors.fill: parent
                     cursorShape: Qt.PointingHandCursor
                     onClicked: MprisServ.next()
                  }
               }
            }
         }
      }
   }
}