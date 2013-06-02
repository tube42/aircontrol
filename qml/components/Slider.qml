
import QtQuick 1.1

import "../js/constants.js" as Constants


Column {    
    id: slider_
    
    width: parent.width
    property bool enabled: true
    property string text
    property int min: 0
    property int max: 100
    
    property int value: -1
    
    spacing: 3    
    opacity: enabled ? 1.0 : 0.4
        
    property int space: Math.max(4, width / 20);
    property int size: Math.max(8, width / 20);
    
    signal valueChanged;
    
    function setValue(x, width)
    {
        var width2 = max - min;
        if(width2 < 1) width2 = 1;
        if(width < 1) width = 1;
        
        var tmp = min + (x * width2) / width;
        if(tmp < min) tmp = min;
        if(tmp > max) tmp = max;
        
        if(slider_.value != tmp) {
            slider_.value = tmp;     
            valueChanged();
        }
    }
    
    Text {
        id: text_        
        width: parent.width
        font.pixelSize: theme.fontSizeNormal
        font.family: appFont
        color: Constants.COLOR_FG
        text: slider_.text
        
    }
    
    Item {
        width: parent.width
        height: slider_.space * 2 + slider_.size
        
        Item {
            id: bar_
            anchors { left: parent.left; right: parent.right; top: parent.top; bottom: parent.bottom; margins: slider_.space }
            
            Rectangle {
                anchors.left: parent.left
                anchors.right: marker_.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: Constants.COLOR_STYLE
            }
            
            Rectangle {
                anchors.left: marker_.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: Constants.COLOR_FG_INACTIVE
            }
            
            Rectangle {
                id: marker_
                y: 0
                width: height
                height: parent.height
                x: Math.max(0, (value - min) * parent.width /  (max - min))  - width / 2
                color: Constants.COLOR_FG
            }
            
            MouseArea {
                anchors.fill: parent
                preventStealing: true                
                onPressed: if(slider_.enabled) slider_.setValue(mouse.x, width);
                onPositionChanged: if(slider_.enabled) slider_.setValue(mouse.x, width);
            }
            
            
        }
    }
    
}
