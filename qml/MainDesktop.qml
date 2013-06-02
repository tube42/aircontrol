
import QtQuick 1.0


Item {    
    width: 360
    height: 630
    
    Main {
        id: main
        anchors.fill: parent
    }

    QtObject {
        id: sound
        property bool enabled: true

        function play(file) {
            if(enabled)
            console.log("Play " + file);
        }
    }
    
    QtObject {
        id: theme        
        property bool showParticles: false
        property int fontSizeLarge: 48
        property int fontSizeTitle: 24
        property int fontSizeNormal: 22
        property int fontSizeSmall: 12
        
        property int fontSizeButtonLarge: fontSizeTitle
        property int fontSizeButtonSmall: fontSizeSmall
        property int fontSizeStatus: fontSizeNormal
        property int fontSizeAbout: fontSizeNormal
        property int fontSizeTopBar: fontSizeLarge
    }
    
    // Fake sensor object
    Timer {
        interval: 8000
        repeat: true;
        running : main.state == "movement"
        id: sensor;

        onTriggered: main.movement.onMoved();
    }
}
