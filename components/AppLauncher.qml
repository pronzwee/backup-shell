import QtQuick
import QtQuick.Controls
import Quickshell

import qs.theme

Rectangle {
   id: root

   property int launcherWidth: 0
   property int launcherHeight: 0

   width: launcherWidth 
   height: launcherHeight
   color: Colors.trans

   Column {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      TextField {
         width: parent.width
         placeholderText: "Search..."
         onTextChanged: {
            if (AppLauncherState.searchQuery !== "") {
               AppLauncherState.searchQuery = text
            }
         }
         Connections {
            target: AppLauncherState
            function onSearchQueryChanged() {
               if (searchField.text !== AppLauncherState.searchQuery) {
                  searchField.text = AppLauncherState.searchQuery
               }
            }
         }
      }
      ListView {
         width: parent.width
         height: parent.height - 50
         clip: true
         model: AppLauncherState.filteredApps

         delegate: ItemDelegate {
            required property var modelData
            width: ListView.view.width
            text: modelData.name
            icon.source: Quickshell.iconPath(modelData.icon, true)
            onClicked: AppLauncherState.launch(modelData)
         }
      }
   }
}