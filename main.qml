import QtQuick 2.5
import QtQuick.Window 2.2


import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import QtQuick.LocalStorage 2.0


Window {
    visible: true
    width: 480
    height: 800
    title: qsTr("TO DOs")

    id:maina

    property real iRatio:0;

    ListModel{
        id:modelTasks
    }

    function addTask(){
        popupTask.myIndex=-1;
        popupTask.action="insert";

        popupTask.open();

        myPopup.reset();
    }

    function calculate(value_){
        return value_*iRatio;
    }

    function launch(sView){
        stack.push(sView);

    }

    function init(width_,height_){

        iRatio=(width/width_);

        launch('qrc:/page_menu.qml')
    }

    function popup(index_ ){

        popupTask.myIndex=index_;
        popupTask.action="update";

        console.log("ask popup "+index_+' titre:'+modelTasks.get(index_).titre);

        popupTask.open();

        myPopup.reset();
        myPopup.loadInfos(index_ );
    }

    Popup {
        id: popupTask
        x: calculate(90)
        y: calculate(100)
        width: calculate(300)
        height: calculate(300)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property int myIndex:0
        property string action:"update"

        Mypopup{
            id:myPopup

        }

    }


    StackView {
        id: stack
        anchors.fill: parent
    }

    //Component.onCompleted:init(Screen.width,Screen.height);
    Component.onCompleted:init(480,800);

}
