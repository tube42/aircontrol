

import QtQuick 1.0

import "../js/constants.js" as Constants


Item {
    
    id: timed_
    property int space: Math.max(6, width / 20);
    property bool counting: false
    
    
    // --------------------------
    property int time_to_go: 0
    function startTimer()
    {
        time_to_go = Constants.TIMER_DELAY_VALUES[delay_.value]
        
        if(addRandom_.value) {
            var r = 75 + Math.random() * 50
            time_to_go = (time_to_go * r) / 100;
        }
        counting = true;
        updateText();
    }
    
    function stopTimer()
    {
        counting = false;
    }
    
    function timerTick()
    {
        if(time_to_go > 0) {
            time_to_go--;
            updateText();
        } else {                
            stopTimer();
            logic.playRandomSound();            
            
            if(doRepeat_.value)
            startTimer();
        }
    }
    function updateText()
    {
        countText_.text = "" + time_to_go;
    }
    // ----------------------------
    Item {
        
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: timed_.space
        anchors.rightMargin: timed_.space        
        anchors.topMargin: timed_.space
        anchors.bottomMargin: timed_.space
        
        
        Text {
            id: countText_
            anchors.centerIn: parent
            visible: timed_.counting            
            color: Constants.COLOR_FG
            font.pixelSize: parent.width / ( 0.1 + text.length)
            text: "-"
        }
        
    
        Column {
            anchors.fill: parent
            visible: !timed_.counting
        
            Slider {
                id: delay_
                value: 1
                min: 0
                max: 3
                text: ""
                onValueChanged: {
                    text = "Delay: " + Constants.TIMER_DELAY_NAMES[value]
                }
            }
            
            
            Checkbox {
                id: addRandom_
                text1: "Randomness"
                text2: "Add +/- 25% randonmess to the time"
                value: true
            }
            
            Checkbox {
                id: doRepeat_
                text1: "Loop"
                text2: "Endless fun"
                value: false
            }
            
        }
        
        
        Button {
            anchors.bottom: parent.bottom
            width: parent.width
            text: timed_.counting ? "Canel" : "Start the timer"
            onClicked: {
                if(timed_.counting)
                timed_.stopTimer();                
                else
                timed_.startTimer();
            }            
        }
    }
    
    
    Timer {
        id: timer_
        running: timed_.counting
        interval: 1000        
        repeat: true
        onTriggered: timed_.timerTick();        
    }
    
    Component.onCompleted: {
        delay_.valueChanged(); // force update
    }
}
