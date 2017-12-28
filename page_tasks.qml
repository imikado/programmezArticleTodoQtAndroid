import QtQuick 2.0
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4

Rectangle {

    width:parent.width
    height:parent.height
    color:"#789598"

    ToolBar {

        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr(" < ")
                onClicked: stack.pop()
            }
            Label {
                text: "TO DOs"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                font.pixelSize: calculate(20)
            }

            ToolButton {
                text: qsTr(" + ")
                onClicked: addTask()
            }

        }
    }

    ColumnLayout{
        y:calculate(80)

        width:parent.width
        spacing:calculate(20)

        Repeater{
            model:modelTasks

            Row{
                Layout.alignment: Qt.AlignCenter
                Rectangle {

                    radius: calculate(10)

                    width:calculate(430)
                    height:calculate(40)

                    color:{
                        if(model.done===1){  "#7cc16f" }
                        else { "#fff" }
                    }


                    Text{
                        x:calculate(10)
                        y:calculate(10)
                        text:model.titre
                        font.pixelSize:calculate(12)

                    }

                    MouseArea{
                        anchors.fill: parent;
                        onClicked:function(){ popup( model.index ); }
                    }


                }

            }
        }
    }
}
