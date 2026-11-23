import Quickshell
import Quickshell.Io

FileView {
   id: configFile
   path: Quickshell.shellDir + "/config.json"

   blockLoading: true
   watchChanges: true
   onFileChanged: reload()

   readonly property var data: {
      try {
         return JSON.parse(configFile.text())
      } catch (e) {
         console.log("error")
         return ({})
      }
   }
   readonly property string username: data.username ?? "no name"
   readonly property string accentColor: data.theme?.accentColor
}