import QtQuick

Rectangle {
   id: root

   default property alias content: contentRow.data
   property int spacing: 10

   width: contentRow + 20
   height: 30
   radius: height / 2

   Row {
      id: contentRow
      anchors.centerIn: parent
      spacing: spacing
   }
}