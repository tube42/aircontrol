

import QtQuick 1.0

import "../js/constants.js" as Constants
import "../js/sounds.js" as Sounds


Item {    
    id: free_
    property int space: Math.max(8, width / 20)
    property int size: Math.min(height, width) * 0.5 - space * 2.5
    
    GridView {
        id: grid      
//        property int size: Math.min(height, width) * 0.5 - space
        
        clip: true
        
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: space        
        anchors.leftMargin: space
//        anchors.rightMargin: space
        anchors.bottomMargin: space
        
        
        cellWidth: free_.size + space
        cellHeight: free_.size + space
        
        model: Sounds.sounds
        
        delegate: Tile {
            size: free_.size
            text1: modelData.text1
            text2: modelData.text2
            onClicked: sound.play(modelData.file);
        }        
    }    
}
