import QtQuick

Text {
   property string icon: ""
   property int size: 14

   text: icon
   font {
      family: "Material Symbols Rounded"
      pixelSize: size
   }
   renderTypeQuality: Text.HighRenderTypeQuality
}