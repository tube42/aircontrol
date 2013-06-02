
// import Qt 4.7
import QtQuick 1.0

import "../js/constants.js" as Constants

Item {
    id: multiView
    
    property int userHeight: list.height
    property int userWidth: width
    
    property int fontSize: 48
    property string fontFamily: "Serif"
    property string colorActive: "white"
    property string colorInactive: "gray"
    
    property int currentIndex: 0
    
    default property alias content: visualModel.children
    
    signal selectionChanged(int index);

    function showPage(index)
    {
        if(index != currentIndex) {
            currentIndex = index;
        }
    }
        
    // ------------------------------------------------------
    Text {
        id: topText
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: font.pixelSize * 1
        anchors.leftMargin: font.pixelSize * 0.5       
        height: font.pixelSize * 1.6
        text: "" + topBar.currentItem.item.title.toUpperCase()
        color: Constants.COLOR_FG
        font.pixelSize: theme.fontSizeNormal     
        font.family: appFont2
        
        
        opacity: (topBar.moving || topBar.flicking || list.moving || list.flicking) ? 0 : 1        
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }    
        
    }
    
    ListView {
        id: topBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topText.bottom
        height:  multiView.fontSize * 1.0 // XXX: why is this needed??
           
        model: visualModel.children
        spacing: multiView.fontSize * 0.8
        orientation: ListView.Horizontal
        clip: true
        
        preferredHighlightBegin : width * 0.2
        preferredHighlightEnd : width * 0.6

        highlightRangeMode: ListView.StrictlyEnforceRange               
        highlightMoveDuration: 350

        currentIndex: multiView.currentIndex
        
        onMovementEnded: {
            if(multiView.currentIndexndex != topBar.currentIndex) {
                multiView.currentIndex = topBar.currentIndex;
                selectionChanged(multiView.currentIndex);
            }
        }
        
        delegate: Text {
            property variant item: modelData // used by topText
            
            anchors.verticalCenter: parent.verticalCenter
            
            font.pixelSize: multiView.fontSize
            font.family: fontFamily
            color: ListView.isCurrentItem ? colorActive : colorInactive
            text: name
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(multiView.currentIndex != index) {
                        multiView.currentIndex = index;
                        selectionChanged(multiView.currentIndex);
                    }
                }
            }
            
            transitions: Transition {
                NumberAnimation { properties: "scale,y" }
            }
            
        }
        
    }
    
    ListView {
        id: list
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        
        currentIndex: multiView.currentIndex
        onCurrentIndexChanged: {
            if(currentIndex != multiView.currentIndex) {
                multiView.currentIndex = currentIndex
                selectionChanged(multiView.currentIndex);
            }
        }
            
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.DragOverBounds
        model: visualModel

        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 350
        
        snapMode: ListView.SnapOneItem
    }
    
    VisualItemModel { 
        id: visualModel 
    }        
}
