
import QtQuick 1.0

import "../js/constants.js" as Constants

Rectangle {
    id: button_
    
    property int size: 32
    property bool enabled: true
    property alias text1: text1.text
    property alias text2: text2.text
    property alias icon1: icon1.source
    
    signal clicked;    
    color: Constants.COLOR_STYLE
    
    
    width: size
    height: size
    
    clip: true
    
    Image {
        id: icon1
        anchors.centerIn: parent       
        
        property int icon1Size: Math.min(parent.width, parent.height) * 0.4
        
        width: icon1Size
        height: icon1Size        
    }
    
    Text {
        id: text1
        anchors.centerIn: parent       
        font.pixelSize: theme.fontSizeButtonLarge
        font.family: appFont
        color: Constants.COLOR_FG
        smooth: true
    }
    
    Text {
        id: text2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: theme.fontSizeButtonSmall / 2
        anchors.rightMargin: theme.fontSizeButtonSmall / 2
        anchors.bottomMargin: theme.fontSizeButtonSmall
        
        font.pixelSize: theme.fontSizeButtonSmall
        font.family: appFont
        color: Constants.COLOR_FG
        smooth: true
        
        width: parent.width - theme.fontSizeButtonSmall
        wrapMode: Text.Wrap
        
    }
    
    
    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: if(enabled) parent.clicked();
    }
    
    states: [
             State {
                 name: "disabled"
                 when: !enabled
                 PropertyChanges { target: button_; opacity: 0.5 }
                 
             },
             State {
                 name: "down"
                 when: enabled && mouse.pressed
                 PropertyChanges { target: button_; opacity: 0.75 }
                 
             },
             State {
                 name: "up"
                 when: enabled && !mouse.pressed
             }
             ]
    
    Behavior on opacity {
        NumberAnimation { duration: 250 }
    }    
}
