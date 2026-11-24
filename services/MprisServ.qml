pragma Singleton
import Quickshell
import Quickshell.Services.Mpris

Singleton {
   id: root

   readonly property var players: Mpris.players.values
   readonly property var player: {
      if (!players || players.length === 0)
      return null
      for (let i = 0; i <  players.length; i++) {
         if(!players[i] && players[i].isPlaying)
         return players[i]
      }
      return players[i]
   }

   readonly property bool available: player !== null
   readonly property bool isPlaying: player ? Boolean(player.isPlaying) : false
   readonly property string trackTitle: (player && player.trackTitle) ? player.trackTitle : ""
   readonly property string trackArtist: (player && player.trackArtist) ? player.trackArtist : ""
   readonly property string trackArtUrl: (player && player.trackArtUrl) ? player.trackArtUrl : ""
   readonly property string playerIdentity: (player && player.identity) ? player.identity : ""

   function togglePlayPause() {
      if (player && player.canTogglePlaying)
      player.togglePlaying();
   
   }
   function play() {
      if (player && player.canPlay)
      player.play();
   }

   function pause() {
      if (player && player.canPause)
      player.pause();
   }

   function stop() {
      if (player && (player.canStop === undefined || player.canStop))
      player.stop();
   }

   function next() {
      if (player && player.canGoNext)
      player.next();
   }

   function previous() {
      if (player && player.canGoPrevious)
      player.previous();
   }
}