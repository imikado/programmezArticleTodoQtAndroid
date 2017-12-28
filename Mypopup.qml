import QtQuick 2.4
import QtQuick.Controls 2.0

Item {

    function reset(){
        textInput.text="";
        textArea.text="";
        switch1.checked=0;

        buttonDelete.visible=false;
    }

    function loadInfos(id_){

        textInput.text=modelTasks.get(id_).titre;
        textArea.text=modelTasks.get(id_).texte;
        if(modelTasks.get(id_).done === 1){
            switch1.checked=1;

            buttonDelete.visible=true;
        }else{
            switch1.checked=0;
        }
    }

    function save(){

        if(popupTask.action === "update"){

            modelTasks.get(popupTask.myIndex ).titre=textInput.text;
            modelTasks.get(popupTask.myIndex ).texte=textArea.text;
            if(switch1.checked){
                modelTasks.get(popupTask.myIndex ).done=1;
            }else{
                modelTasks.get(popupTask.myIndex ).done=0;
            }

        }else{
            modelTasks.append({titre:textInput.text,texte:textArea.text,done:0});
        }

    }

    function remove(){
        if(popupTask.action === "update"){
            modelTasks.remove(popupTask.myIndex);
        }

    }

    width: parent.width
    height: parent.height

    id:mainForm

    Text {
        id: text1
        x: calculate(20)
        y: calculate(44)
        text: qsTr("Titre")
        font.pixelSize: calculate(12)
    }

    TextField {
        id: textInput
        x: calculate(60)
        y: calculate(30)
        width: calculate(190)
        height: calculate(40)
        text: qsTr("Text Input")
        font.pixelSize: calculate(12)
    }

    Rectangle{
        color: "#ddd"
        x: calculate(20)
        y: calculate(82)
        width: calculate(230)
        height: calculate(60)


        TextArea {
            id: textArea
            text: qsTr("Text Area")
            width:parent.width
            height:parent.height
        }
    }

    Switch {
        id: switch1
        x: calculate(20)
        y: calculate(147)
        text: qsTr("Fait")
        font.pixelSize: calculate(12)
    }

    Button {
        id: button
        x: calculate(130)
        y: calculate(215)
        width:calculate(120)
        text: qsTr("Valider")
        font.pixelSize: calculate(12)

        onClicked:function(){
            save();
            popupTask.close();
        }
    }

    Button {
        visible:false;
        id: buttonDelete
        x: calculate(1)
        y: calculate(215)
        width:calculate(120)
        text: qsTr("Supprimer")
        font.pixelSize: calculate(12)

        background: Rectangle {
            width:parent.width
            height:parent.height

            color:"red"
        }

        onClicked:function(){
            remove()
            popupTask.close();
        }
    }

}
