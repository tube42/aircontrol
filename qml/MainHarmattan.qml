
import QtQuick 1.0
import com.nokia.meego 1.0
import QtMultimediaKit 1.1
// import Qt.multimedia 1.0
import QtMobility.sensors 1.1

PageStackWindow {
    initialPage: mainPage

    Page{
        id: mainPage
        orientationLock: PageOrientation.LockPortrait
        Main {
            id: main
            anchors.fill: parent
        }
    }
    
    Audio {
        id: audio
    }

    QtObject {
        id: sound
        property bool enabled: true
        
        function play(file) {
//            console.log("enabled=", enabled, ", file=", file); // DEBUG

            if(!enabled) return;
            
            audio.source = file;
            audio.play();
        }
    }

    
    QtObject {
        id: theme        
        property bool showParticles: true
        
        property int fontSizeLarge: 54
        property int fontSizeTitle: 28
        property int fontSizeNormal: 28
        property int fontSizeSmall: 14
        
        property int fontSizeButtonLarge: fontSizeTitle
        property int fontSizeButtonSmall: fontSizeSmall
        property int fontSizeStatus: fontSizeNormal
        property int fontSizeAbout: fontSizeNormal
        property int fontSizeTopBar: fontSizeLarge    
    }
    

    // detect app minimization in harmattan
    Connections {
         target: platformWindow
//         onViewModeChanged: console.log("** VIEWMODE", platformWindow, platformWindow.viewMode)
//         onVisibleChanged: console.log("** VISIBLE", platformWindow, platformWindow.visible)
//         onActiveChanged: console.log("** ACTIVE", platformWindow, platformWindow.active)
         onActiveChanged: main.active = platformWindow.active
     }
     
     // the real sensor
     OrientationSensor {         
         id: sensor
         dataRate: 1 // 1 Hz         
         active: main.state == "movement"
         
         property variant last_data
         
         onReadingChanged: {
             if(last_data != reading.orientation) {
                 if(last_data)
                     main.movement.onMoved();
                 last_data = reading.orientation;
             }
         }
     }     
}
