
import QtQuick 1.0

import "../js/constants.js" as Constants

Rectangle {
    id: button_
    property bool enabled: true
    property alias text: text_.text
    
    
    height: text_.font.pixelSize * 1.8
    color:  state != "down" ? Constants.COLOR_BG : Constants.COLOR_STYLE
    clip: true
    
    border.width: 3
    border.color: Constants.COLOR_STYLE
    
    signal clicked
    
    
    Text {
        id: text_
        anchors.centerIn: parent       
        font.pixelSize: theme.fontSizeButtonLarge
        font.family: appFont
        color: button_.state != "down" ? Constants.COLOR_STYLE : Constants.COLOR_BG
        smooth: true
        
    }
    
    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: if(button_.enabled) parent.clicked();
    }
    
    states: [
             State {
                 name: "disabled"
                 when: !button_.enabled
                 PropertyChanges { target: button_; opacity: 0.4 }                 
             },
             State {
                 name: "down"
                 when: button_.enabled && mouse.pressed
             },
             State {
                 name: "up"
                 when: button_.enabled && !mouse.pressed
             }
             ]
    
    Behavior on opacity {
        NumberAnimation { duration: 250 }
    }    
    
    Behavior on color {
        ColorAnimation { duration: 250 }
    }    
    
}

