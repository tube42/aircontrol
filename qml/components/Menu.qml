

import QtQuick 1.0

import "../js/constants.js" as Constants


Item {
    id: menu
    

    property int sizeArrow: Math.round(width * 0.05) * 2
    
    property int buttonWidth: (width - sizeArrow) * 0.9
    
    

    Image {
        id: arrowImage

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin:  sizeArrow * 0.2
        anchors.topMargin:  sizeArrow * 1.5

        width: sizeArrow; height:  sizeArrow

        source: "../images/arrow.png"
        smooth: true
        opacity: 1

        rotation: app.state == "menu"  ? 0: 180
        Behavior on rotation { NumberAnimation { duration: 250 } }
        
        MouseArea {
            anchors.fill: parent
            onClicked: logic.setPage(1);
        }
    }

    Text {
        id: hint
        anchors.bottom: parent.bottom
        anchors.bottomMargin: font.pixelSize

        width: parent.width
        wrapMode: Text.WordWrap
        color: Constants.COLOR_FG
        font.pixelSize: theme.fontSizeSmall
        text: "Note: you can swipe or use the top menu to navigate between the pages"
    }


    Flickable {
        anchors.left: parent.left
        anchors.right: arrowImage.left; // parent.right
        anchors.top: parent.top
        anchors.bottom: hint.top
        anchors.topMargin: 32
        anchors.leftMargin: 8

        flickableDirection: Flickable.VerticalFlick

        contentWidth: parent.width
        contentHeight: grid.height
        clip: true

        Column {
            id: grid
            //            columns: 1
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: parent.width * 0.05
            
            
            Button {                 
                width: buttonWidth
                text: "Free practice"
                onClicked: logic.setPage(1);
            } 
            
           Button {                 
                width: buttonWidth
                text: "Timed"
                onClicked: logic.setPage(2);
            } 
            
           Button {                 
                width: buttonWidth
                text: "On movements"
                onClicked: logic.setPage(3);
            } 
            
            Button {                 
                width: buttonWidth
                text: "About"
                onClicked: logic.setPage(4);
            } 
            
            Button {                 
                width: buttonWidth
                text: "Quit"
                onClicked: Qt.quit();
            } 
            
            
        }
    }
}
