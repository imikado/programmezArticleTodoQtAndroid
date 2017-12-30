import QtQuick 2.5
import QtQuick.Window 2.2


import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import QtQuick.LocalStorage 2.0


Window {
    property bool dev:true

    property int _width: 480
    property int _height: 800

    width:{ if(dev===true){ _width }else{ Screen.width } }
    height:{ if(dev===true){ _height }else{ Screen.height } }

    visible: true
    title: qsTr("TO DOs")
    id:maina

    property real iRatio:0;

    ListModel{
        id:modelTasks
    }


    function launch(sView){
        stack.push(sView);
    }
    function calculate(value_){
        return value_*iRatio;
    }
    function init(){

        iRatio=(width/_width);

        launch('qrc:/page_menu.qml')
    }

    //tasks
    function addTask(){
        popupTask.myIndex=-1;
        popupTask.action="insert";

        popupTask.open();

        myPopup.reset();
    }
    function saveTask(){

        if(popupTask.action === "update"){

            modelTasks.get(popupTask.myIndex ).titre=myPopup.getInputText();
            modelTasks.get(popupTask.myIndex ).texte=myPopup.getTextarea();
            if(myPopup.getSwitchChecked() ){
                modelTasks.get(popupTask.myIndex ).done=1;
            }else{
                modelTasks.get(popupTask.myIndex ).done=0;
            }

        }else{
            modelTasks.append({titre:myPopup.getInputText(),texte:myPopup.getTextarea(),done:0});
        }

        popupTask.close();

    }
    function removeTask(){
        if(popupTask.action === "update"){
            modelTasks.remove(popupTask.myIndex);
        }

        popupTask.close();
    }

    function editTask(index_ ){

        popupTask.myIndex=index_;
        popupTask.action="update";

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

    Component.onCompleted:init();

}
