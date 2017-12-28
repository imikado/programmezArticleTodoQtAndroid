import QtQuick 2.4
import QtQuick.Controls 2.0



Item {
    width: 400
    height: 400

    id:mainForm

    TextInput {
        id: textInput
        x: 88
        y: 41
        width: 212
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    Text {
        id: text1
        x: 40
        y: 44
        text: qsTr("Titre")
        font.pixelSize: 12
    }

    TextArea {
        id: textArea
        x: 40
        y: 72
        width: 299
        height: 160
        text: qsTr("Text Area")
    }

    Switch {
        id: switch1
        x: 229
        y: 247
        text: qsTr("done")
    }

    Button {
        id: button
        x: 243
        y: 315
        text: qsTr("Valider")
    }
}
