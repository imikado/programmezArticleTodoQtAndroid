import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Rectangle {

    width:parent.width
    height:parent.height
    color:"#789598"

    Text{
        id:myTitle
        y:calculate(40)
        text:"TO DO"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: calculate(60)
        font.bold: true
        color: "#05a5b3"
    }

    DropShadow {
        anchors.fill: myTitle
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: myTitle
    }

    ColumnLayout{
        y:calculate(140)
        width:parent.width
        spacing:calculate(20)

        Rectangle {
            Layout.alignment: Qt.AlignCenter
            radius: calculate(10)
            width:calculate(430)
            height:calculate(40)
            color: "#ddd"

            Text{
                x:calculate(10)
                y:calculate(10)
                text:"Liste des taches"
                font.pixelSize:calculate(12)
            }

            MouseArea{
                anchors.fill: parent;
                onClicked:function(){ launch('qrc:/page_tasks.qml'); }
            }
        }



        Rectangle {
            Layout.alignment: Qt.AlignCenter
            radius: calculate(10)
            width:calculate(430)
            height:calculate(40)
            color: "#ddd"

            Text{
                x:calculate(10)
                y:calculate(10)
                text:"Autre menu"

                font.pixelSize:calculate(12)
            }

            MouseArea{
                anchors.fill: parent;
                onClicked:alert("votre menu")
            }
        }

    }
}
