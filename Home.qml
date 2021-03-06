import QtQuick 2.11
import QtQuick.Controls 2.4

Page {
    id: home
    title: qsTr("Installed hApps")
    Rectangle{
        color: "#4d4d4d"
        anchors.fill: parent
        Image {
            id: splashImage
            width: parent.width -50
            fillMode: Image.PreserveAspectFit
            x: (parent.width - splashImage.width) / 2
            y: 10
            source: "qrc:/images/Holochain_logo"
        }
        Grid {
            id: grid
            anchors.centerIn: parent
            columns: 3
            spacing: 20
            Image {
                source: "qrc:/images/HoloChat_Logo.png"
                width: 100
                height: 100
                MouseArea {
                   id: touchArea
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("Channels.qml")
                    }
                }
            }
            Image {
                source: "qrc:/images/Chess.png"
                width: 100
                height: 100
            }
            Image {
                source: "qrc:/images/holochain-circle-lrg.png"
                width: 100
                height: 100
            }
            Image {
                source: "qrc:/images/holochain-circle-lrg.png"
                width: 100
                height: 100
            }
            Image {
                source: "qrc:/images/holochain-circle-lrg.png"
                width: 100
                height: 100
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
