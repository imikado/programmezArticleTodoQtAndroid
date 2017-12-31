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

    property var _db;

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

        _db = LocalStorage.openDatabaseSync("myTasksDb", "1.0", "My tasks", 1000000);

        _db.transaction(
                    function(tx) {
                        // Creation de la table si elle n'existe pas
                        tx.executeSql('CREATE TABLE IF NOT EXISTS MyTasks(id INTEGER PRIMARY KEY,titre TEXT, texte TEXT, done INT)');

                        var rs = tx.executeSql('SELECT * FROM MyTasks');

                        //boucle sur les taches stoquees en SQL pour les ajouter au model de l'application
                        for (var i = 0; i < rs.rows.length; i++) {

                            modelTasks.append({
                                            titre:rs.rows.item(i).titre,
                                            texte:rs.rows.item(i).texte,
                                            done:rs.rows.item(i).done,
                                            id:rs.rows.item(i).id
                                        });
                        }
                    }
        );

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

            var oUpdateRow=modelTasks.get(popupTask.myIndex );

            oUpdateRow.titre=myPopup.getInputText();
            oUpdateRow.texte=myPopup.getTextarea();
            if(myPopup.getSwitchChecked() ){
                oUpdateRow.done=1;
            }else{
                oUpdateRow.done=0;
            }

            _db.transaction(
                        function(tx) {
                            // Create the database if it doesn't already exist
                            tx.executeSql('UPDATE MyTasks SET titre=?,texte=?,done=? WHERE id=?',[
                                              oUpdateRow.titre,
                                              oUpdateRow.texte,
                                              oUpdateRow.done,
                                              oUpdateRow.id

                                          ]);
                        }
                        );

        }else{
            var oNewRow={titre:myPopup.getInputText(),texte:myPopup.getTextarea(),done:0};
            oNewRow.id=modelTasks.count;

            _db.transaction(
                        function(tx) {
                            // Insert tasks
                            tx.executeSql('INSERT INTO MyTasks (titre,texte,done,id) VALUES (?,?,?,?)',[
                                              oNewRow.titre,
                                              oNewRow.texte,
                                              oNewRow.done,
                                              oNewRow.id

                                          ]);
                        }
                        );

            modelTasks.append(oNewRow);


        }

        popupTask.close();

    }
    function removeTask(){
        if(popupTask.action === "update"){

            _db.transaction(
                        function(tx) {
                            // Insert tasks
                            tx.executeSql('DELETE FROM MyTasks WHERE id=?',[
                                              modelTasks.get(popupTask.myIndex ).id

                                          ]);
                        }
                        );


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
