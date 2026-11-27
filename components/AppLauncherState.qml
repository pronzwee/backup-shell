pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    property bool isOpen: false
    property string searchQuery: ""
    
    function toggle() {
        isOpen = !isOpen
        if (!isOpen) searchQuery = ""
    }

    function launch(entry) {
        if (!entry) return
        entry.execute()
        isOpen = false
        searchQuery = ""
    }
    readonly property var filteredApps: {
        const allApps = DesktopEntries.applications.values
        const q = searchQuery.trim().toLowerCase()

        return allApps.filter(app => {
            if (app.noDisplay) return false
            if (q === "") return true
            return app.name.toLowerCase().includes(q) ||
            (app.genericName && app.genericName.toLowerCase().includes(q))
        })
    }
}