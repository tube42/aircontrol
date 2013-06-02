

import QtQuick 1.0

import "../js/constants.js" as Constants


Item {
    id: movement_
    property int space: Math.max(6, width / 20);
    
    property variant last_time

    function onMoved()
    {
        var date = new Date();
        var now = date.getHours() * 3600 + date.getMinutes() * 60 + date.getSeconds();

        if((!last_time) || (last_time + Constants.SENSOR_REPEAT_VALUES[repeat_.value] < now)) {
            last_time = now;
            logic.playRandomSound();
        }
    }

    // ----------------------------
    Item {
        
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: movement_.space
        anchors.rightMargin: movement_.space        
        anchors.topMargin: movement_.space
        anchors.bottomMargin: movement_.space
                    
        Column {
            anchors.fill: parent
//            visible: !movement_.counting
                   
            Slider {
                id: repeat_
                value: 1
                min: 0
                max: 5
                text: ""
                onValueChanged: {
                    text = "Repeat lock: " + Constants.SENSOR_REPEAT_NAMES[value]
                }
            }
            
            Slider {
                id: sensitivity_
                value: 1
                min: 0
                max: 2
                text: ""
                enabled: false
                onValueChanged: {
                    text = "Sensitivity: " + Constants.SENSOR_SENSITIVITY_NAMES[value]
                }
            }

            Checkbox {
                id: awake_
                text1: "Keep awake"
                text2: "Keep phone awake and waste battery "
                enabled: false
                value: false
            }
        }
    }
    
    // --------------------------------
    
    Component.onCompleted: {
        // force update
        sensitivity_. valueChanged();
        repeat_.valueChanged();
        
    }
}
