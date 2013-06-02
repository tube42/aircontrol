
import QtQuick 1.0

import "../js/constants.js" as Constants

Flickable{

    flickableDirection: Flickable.VerticalFlick

    contentWidth: width
    contentHeight: text_.height    
    
    Text {
        id: text_
        anchors.centerIn: parent
        width: parent.width * 0.9
        textFormat: Text.RichText
        wrapMode: Text.WordWrap
        color: Constants.COLOR_FG
        font.pixelSize: theme.fontSizeAbout
        text: Constants.APP_ABOUT_TEXT
        onLinkActivated: Qt.openUrlExternally(link)
    }
    clip: true
}

