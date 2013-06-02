
import QtQuick 1.0

import "../js/constants.js" as Constants


Item {
    id: cb_
    
    width: parent.width
    height: line_.height + text2_.height + space
    
    property string text1
    property string text2
    property bool enabled: true       
    property bool value: false
    opacity: enabled ? 1.0 : 0.4
    
    property int space: Math.max(6, width / 20)
    
    // ---------------------------
    
    Item {        
        id: line_
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: cb_.space
        anchors.rightMargin: cb_.space
                        
        height: text1_.height * 1.2
        
        Rectangle {
            id: box_
            anchors.left: parent.left
            width: text1_.height
            height: text1_.height
            
            color:  cb_.value ? Constants.COLOR_STYLE : Constants.COLOR_BG
           
            border.width: 3
            border.color: Constants.COLOR_STYLE
            
            Behavior on color {
                ColorAnimation { duration: 250 }
            }                            
            
        }
        
        Text {
            id: text1_
            anchors.left: box_.right
            anchors.leftMargin: cb_.space
            anchors.right: parent.right
            font.pixelSize: theme.fontSizeNormal
            font.family: appFont
            color: Constants.COLOR_FG
            smooth: true
            
            text: text1
        }    
        
        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: {
                if(cb_.enabled) cb_.value = ! cb_.value
            }
        }
        
    }            
    
    Text {
        id: text2_
        
        anchors.left: parent.left
        anchors.leftMargin:  font.pixelSize * 2
        anchors.top: line_.bottom
        font.pixelSize: theme.fontSizeSmall
        font.family: appFont
        color: Constants.COLOR_FG
        text: text2
    }
    
            
    
}
