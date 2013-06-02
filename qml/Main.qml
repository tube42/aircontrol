
import QtQuick 1.0
import Qt.labs.particles 1.0

import "components"
import "js/constants.js" as Constants

Rectangle {
    id: app
    color: Constants.COLOR_BG    

    property bool active: true
    property variant movement

    // property string appFont: "SegoeWP" // "Serif"
    FontLoader { id: fontLoader; source: "fonts/SegoeWP-Light.ttf" }
    FontLoader { id: fontLoader2; source: "fonts/SegoeWP.ttf" }
    property variant appFont: fontLoader.name
    property variant appFont2: fontLoader2.name
    
    Logic { id: logic } 
    
    

    // -------------------------------------
    // particle stuff
    function burstParticles()
    {
        if(theme.showParticles && app.active) {
            particles1_.burst(20);
            particles2_.burst(20);
        }
    }
    
    Particles {
        id: particles1_
        width: parent.width
        height: parent.height / 2
        anchors.bottom: parent.bottom
        
        source: "images/particle1.png"
        lifeSpan: 6000
        lifeSpanDeviation: 3000
        count: (theme.showParticles && app.active) ? 10 : 0
        angle: -90
        angleDeviation: 45
        velocity: 50
        velocityDeviation: 30
    }    
    
    
    Particles {
        id: particles2_
        width: parent.width
        height: parent.height / 2
        anchors.bottom: parent.bottom
        
        source: "images/particle2.png"
        lifeSpan: 6000
        lifeSpanDeviation: 3000
        count: (theme.showParticles && app.active) ? 10 : 0
        angle: -90
        angleDeviation: 45
        velocity: 50
        velocityDeviation: 30
    }    
     
    
    MultiView{
        id: mv
        anchors.fill: parent
        
        fontSize: theme.fontSizeLarge
        fontFamily: appFont
        
        onSelectionChanged: logic.setPage(index)
        
        Menu {
            id: menu
            property string name : "Menu"
            property string title: Constants.APP_NAME
            width: mv.userWidth; height: mv.userHeight
        }
        Free {
            id: free
            property string name : "Free"
            property string title: "Practice till you drop..."
            
            width: mv.userWidth; height: mv.userHeight
        }
        
        Timed {
            id: timed
            property string name: "Timed"
            property string title: "Do it in the future!"
            
            width: mv.userWidth; height: mv.userHeight
        }
        
        Movement {
            id: movement
            property string name: "On movement"
            property string title: "Don't anybody move!"            
            width: mv.userWidth; height: mv.userHeight

            Component.onCompleted: {
                app.movement = movement;
            }
        }
        
        About {
            id: about
            property string name: "About..."
            property string title: "WHY? WHY??"
            
            width: mv.userWidth; height: mv.userHeight
        }        
    }

    // --------------------------------------------------------------------------
/*
    function onMoved()
    {
        app.mv.movement.onMoved();
    }
*/
    Component.onCompleted:
    {
        logic.setPage(0)
    }
    
}
