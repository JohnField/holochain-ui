import QtQuick 2.11
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.0
import QtGraphicalEffects 1.0

Page {

    id: schedule
    property string findTimeWith
    property string chosenDate
    property int day: Date().getDay()
    property int month: Date().getMonth()
    property int year: Date().getFullYear()
    property string inviteNotes
    property string selectedTime
    property string selectedMeeting
    property string rememberChannel
    property string meetSpace

   /* function dateChange() {

        if (isNaN(chosenDate)){
            month++
            day = 1
            console.debug(year, month, day)
        }
        else
            day++
            console.debug(year, month, day)

}*/

    title: "Schedule a meeting with " + findTimeWith

    ColumnLayout {
        anchors.fill: parent

            ScrollView {
                Layout.alignment: Qt.AlignHCenter
                width: parent.width / 2
                Layout.maximumHeight: 200
                contentHeight: 200
                contentWidth: 200

                ScrollBar.vertical.policy: ScrollBar.AlwaysOff


                ListView {
                    model: 365
                    delegate: ItemDelegate {
                        text: {
                            if (index==0){
                                return chosenDate = new Date().toLocaleDateString(Qt.locale("en_AU"))
                            }
                            else
                                chosenDate

                    }
                    onActiveFocusChanged: {
                        console.log(chosenDate)
                    }

                }

            }
         }

        JsonModel {
            id: arcs
            dataUrl: "data/presence_" + rememberChannel + ".json"
            onIsLoaded: {
                console.log("model" + model.get(0).booked.get(0).bookedBegin)
            }
        }
        Pane {
            id: presence
            Layout.alignment: Qt.AlignHCenter
            RowLayout {
                Layout.fillWidth: true
                width: parent.width
                TimeWedges {
                    Layout.alignment: Qt.AlignHCenter
                    presenceArcs: arcs.model
                    width: 300
                    height: 300

                }
            }
        }

        Label {
            width: parent.width
            wrapMode: Label.Wrap
            Layout.alignment: Qt.AlignHCenter
            text: "Meeting details"
        }

        RowLayout
        {
            Layout.alignment: Qt.AlignHCenter
            spacing: 6

            TextField{
                        id:timeBegin
                        text : "00:00"
                        inputMask: "99:99"
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegExpValidator { regExp: /^([0-1\s]?[0-9\s]|2[0-3\s]):([0-5\s][0-9\s])$ / }

                        width:100
                        height:50
                        background:Rectangle{
                            color:"transparent"
                            border.color: "black"
                            border.width:2
                            radius:(width * 0.05)
                        }
                    }
            Text {
                text: "to"
            }

            TextField{
                        id:timeEnd
                        text : "00:00"
                        inputMask: "99:99"
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegExpValidator { regExp: /^([0-1\s]?[0-9\s]|2[0-3\s]):([0-5\s][0-9\s])$ / }

                        width:100
                        height:50
                        background:Rectangle{
                            color:"transparent"
                            border.color: "black"
                            border.width:2
                            radius:(width * 0.05)
                        }
                    }
        }

        ComboBox {
            Layout.alignment: Qt.AlignHCenter
            width: 800
            editable:true
            currentIndex: 0
            model: ListModel {
                id: zoomRoom
                ListElement { text: "Teal Room"}
                ListElement { text: "Yellow Room"}
                ListElement { text: "[Zoom link]"}

            }
            onCurrentIndexChanged: {

                 console.debug(zoomRoom.get(currentIndex).text)
                 meetSpace = zoomRoom.get(currentIndex).text
             }
            onAccepted: {
                if (find(editText) === -1)
                    meetSpace = model.append({text: editText})
            }
            onFocusChanged: {
                meetSpace = zoomRoom.get(currentIndex).text
            }



        }
        ComboBox {
            Layout.alignment: Qt.AlignHCenter

            currentIndex: 0
            editable:true
            model: ListModel {
                id: meetingType
                ListElement { text: "[Title]"}
                ListElement { text: "Heartbeat"}
                ListElement { text: "Interview"}
                ListElement { text: "Knowledge Transfer"}
            }
            width: 600
            onFocusChanged: {
                selectedMeeting = meetingType.get(currentIndex).text
            }

            onCurrentIndexChanged: {

                console.debug(meetingType.get(currentIndex).text)
                selectedMeeting = meetingType.get(currentIndex).text
            }
            onAccepted: {
                if (find(editText) === -1)
                    selectedMeeting = model.append({text: editText})
            }

        }


        TextArea {
            id: notes
            Layout.alignment: Qt.AlignHCenter
            placeholderText: ("Enter notes: ")

        }
        CommonButton {
            id: submitInvite
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Invite")
            enabled: true
            onClicked: {
                inviteNotes = "Invitation for \""+ selectedMeeting + "\" sent: " + chosenDate + " from " + timeBegin.text + " - " + timeEnd.text + " in " + meetSpace
                schedule.StackView.view.push("qrc:/Chat.qml",{inviteDetails: inviteNotes , channelName: rememberChannel , inConversationWith: findTimeWith})
            }
        }
    }

}


