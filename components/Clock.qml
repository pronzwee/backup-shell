pragma Singleton
import Quickshell
import QtQuick

SystemClock {
   id: clock
   precision: SystemClock.second

   property string minutes: Qt.formatDateTime(clock.date, "mm")
   property string hours: Qt.formatDateTime(clock.date, "hh")
   property string seconds: Qt.formatDateTime(clock.date, "ss")
}