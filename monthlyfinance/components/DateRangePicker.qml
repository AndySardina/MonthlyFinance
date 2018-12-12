// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import Qt.labs.calendar 1.0
import QtQuick.Controls.Material 2.4

import assets 1.0

Popup {
    id: datePickerRoot
    closePolicy: Popup.CloseOnPressOutside
    property date fromSelectedDate: new Date()
    property date toSelectedDate: new Date()
    property int fromDisplayMonth: fromSelectedDate.getMonth()
    property int toDisplayMonth: toSelectedDate.getMonth()
    property int fromDisplayYear: fromSelectedDate.getFullYear()
    property int toDisplayYear: toSelectedDate.getFullYear()
    //    property int calendarWidth: isLandscape? parent.width * 0.70 : parent.width * 0.85
    property int calendarWidth: parent.width * 0.85
    //    property int calendarHeight: isLandscape? appWindow.height * 0.94 : parent.height * 0.85
    property int calendarHeight: parent.height * 0.85
    property bool isOK: false

    x: (parent.width - calendarWidth) / 2
    y: ((parent.height - calendarHeight) / 2) - 24
    z: 2
    implicitWidth: calendarWidth
    implicitHeight: calendarHeight

    //    background: Rectangle {color:cardAndDialogBackground}

    topPadding: 0
    leftPadding: 0
    rightPadding: 0

    ColumnLayout {
        id:container

        width: datePickerRoot.calendarWidth
        height: datePickerRoot.calendarHeight

        RowLayout
        {
            Layout.preferredHeight: datePickerRoot.calendarHeight / 2
            GridLayout {
                id: fromCalendarGrid
                // column 0 only visible if Landscape
                columns: 3
                // row 0 only visible if Portrait
                rows: 5
                width: datePickerRoot.calendarWidth / 2

                Pane {
                    id: portraitHeader
                    //            visible: !isLandscape
                    visible: false
                    padding: 0
                    Layout.columnSpan: 2
                    Layout.column: 1
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                color: primaryDarkColor
                    }
                    ColumnLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 6
                        Label {
                            topPadding: 12
                            leftPadding: 24
                            font.pointSize: 18
                            text: datePickerRoot.fromDisplayYear
                            color: Style.textOnPrimary
                            opacity: 0.8
                        }
                        Label {
                            leftPadding: 24
                            bottomPadding: 12
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.fromSelectedDate, "ddd")+", "+Qt.formatDate(datePickerRoot.fromSelectedDate, "d")+". "+Qt.formatDate(datePickerRoot.fromSelectedDate, "MMM")
                            color: Style.textOnPrimary
                        }
                    }
                } // portraitHeader

                Pane {
                    id: landscapeHeader
                    //            visible: isLandscape
                    visible: false
                    padding: 0
                    Layout.column: 0
                    Layout.row: 0
                    Layout.rowSpan: 5
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                color: primaryDarkColor
                    }
                    ColumnLayout {
                        spacing: 6
                        Label {
                            topPadding: 12
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 18
                            text: datePickerRoot.fromDisplayYear
                            //                    color: textOnPrimary
                            opacity: 0.8
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.fromSelectedDate, "ddd")
                            //                    color: textOnPrimary
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.toSelectedDate, "d")+"."
                            //                    color: textOnPrimary
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.fromSelectedDate, "MMM")
                            //                    color: textOnPrimary
                        }
                    }
                } // landscapeHeader

                ColumnLayout {
                    id: title
                    Layout.columnSpan: 2
                    Layout.column: 1
                    Layout.row: 1
                    Layout.fillWidth: true
                    spacing: 6
                    RowLayout {
                        height: implicitHeight * 2
                        spacing: 6
                        ButtonFlat {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            text: "<"
                            textColor: Material.foreground
                            onClicked: {
                                if(datePickerRoot.fromDisplayMonth > 0) {
                                    datePickerRoot.fromDisplayMonth --
                                } else {
                                    datePickerRoot.fromDisplayMonth = 11
                                    datePickerRoot.fromDisplayYear --
                                }
                            }
                        }
                        Label {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 3
                            text: monthGrid.title
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 18
                        }
                        ButtonFlat {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            text: ">"
                            textColor: Material.foreground
                            onClicked: {
                                if(datePickerRoot.fromDisplayMonth < 11) {
                                    datePickerRoot.fromDisplayMonth ++
                                } else {
                                    datePickerRoot.fromDisplayMonth = 0
                                    datePickerRoot.fromDisplayYear ++
                                }
                            }
                        }
                    } // row layout title
                } // title column layout

                // TODO not working in dark theme
                DayOfWeekRow {
                    id: dayOfWeekRow
                    Layout.column: 2
                    Layout.row: 2
                    rightPadding: 24
                    Layout.fillWidth: true
                    font.bold: false
                    delegate: LabelBodySecondary {
                        text: model.shortName
                        font: dayOfWeekRow.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                } // day of weeks

                // TODO not working in dark theme
                WeekNumberColumn {
                    id: weekNumbers
                    Layout.column: 1
                    Layout.row: 3
                    Layout.fillHeight: true
                    leftPadding: 24
                    font.bold: false
                    month: datePickerRoot.fromDisplayMonth
                    year: datePickerRoot.fromDisplayYear
                    delegate: LabelBodySecondary {
                        text: model.weekNumber
                        font: weekNumbers.font
                        //font.bold: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                } // WeekNumberColumn


                MonthGrid {
                    id: monthGrid
                    Layout.column: 2
                    Layout.row: 3
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    rightPadding: 24

                    month: datePickerRoot.fromDisplayMonth
                    year: datePickerRoot.fromDisplayYear

                    // ATTENTION: on Qt 5.9 clicked signal only if clicked with mouse
                    // no event if tapped on a day
                    // https://bugreports.qt.io/browse/QTBUG-61585
                    // fixed in 5.9.2
                    // so as a woraround I added a MouseArea for the delegate Label
                    //            onClicked: {
                    //                // Important: check the month to avoid clicking on days outside where opacity 0
                    //                if(date.getMonth() == datePickerRoot.fromDisplayMonth) {
                    //                    datePickerRoot.fromSelectedDate = date
                    //                    console.log("tapped on a date ")
                    //                } else {
                    //                    console.log("outside valid month "+date.getMonth())
                    //                }
                    //            }

                    delegate: Label {
                        id: dayLabel
                        readonly property bool selected: model.day === datePickerRoot.fromSelectedDate.getDate()
                                                         && model.month === datePickerRoot.fromSelectedDate.getMonth()
                                                         && model.year === datePickerRoot.fromSelectedDate.getFullYear()
                        text: model.day
                        font.bold: model.today? true: false
                        opacity: model.month === monthGrid.month ? 1 : 0
                        color: pressed || selected ? Material.primary : model.today ? Material.accent : Material.foreground
                        minimumPointSize: 8
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        background: Rectangle {
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 1.2
                            height: width
                            radius: width / 2
                            color: Style.primaryColor
                            visible: pressed || parent.selected
                        }
                        // WORKAROUND !! see onClicked()
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("mouse as click")
                                // Important: check the month to avoid clicking on days outside where opacity 0
                                if(date.getMonth() === datePickerRoot.fromDisplayMonth) {
                                    datePickerRoot.fromSelectedDate = date
                                    console.log("tapped on a date ")
                                } else {
                                    console.log("outside valid month "+date.getMonth())
                                }
                            }
                        } // mouse
                    } // label in month grid
                } // month grid
            } // grid layout

            GridLayout {
                id: toCalendarGrid
                // column 0 only visible if Landscape
                columns: 3
                // row 0 only visible if Portrait
                rows: 5
                width: datePickerRoot.calendarWidth / 2

                Pane {
                    id: toPortraitHeader
                    //            visible: !isLandscape
                    visible: false
                    padding: 0
                    Layout.columnSpan: 2
                    Layout.column: 1
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                color: primaryDarkColor
                    }
                    ColumnLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 6
                        Label {
                            topPadding: 12
                            leftPadding: 24
                            font.pointSize: 18
                            text: datePickerRoot.toDisplayYear
                            //                    color: textOnPrimary
                            opacity: 0.8
                        }
                        Label {
                            leftPadding: 24
                            bottomPadding: 12
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.toSelectedDate, "ddd")+", "+Qt.formatDate(datePickerRoot.toSelectedDate, "d")+". "+Qt.formatDate(datePickerRoot.toSelectedDate, "MMM")
                            //                    color: textOnPrimary
                        }
                    }
                } // portraitHeader

                Pane {
                    id: toLandscapeHeader
                    //            visible: isLandscape
                    visible: false
                    padding: 0
                    Layout.column: 0
                    Layout.row: 0
                    Layout.rowSpan: 5
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                color: primaryDarkColor
                    }
                    ColumnLayout {
                        spacing: 6
                        Label {
                            topPadding: 12
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 18
                            text: datePickerRoot.toDisplayYear
                            //                    color: textOnPrimary
                            opacity: 0.8
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.toSelectedDate, "ddd")
                            //                    color: textOnPrimary
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.toSelectedDate, "d")+"."
                            //                    color: textOnPrimary
                        }
                        Label {
                            leftPadding: 24
                            rightPadding: 24
                            font.pointSize: 36
                            text: Qt.formatDate(datePickerRoot.toSelectedDate, "MMM")
                            //                    color: textOnPrimary
                        }
                    }
                } // landscapeHeader

                ColumnLayout {
                    id: toTitle
                    Layout.columnSpan: 2
                    Layout.column: 1
                    Layout.row: 1
                    Layout.fillWidth: true
                    spacing: 6
                    RowLayout {
                        height: implicitHeight * 2
                        spacing: 6
                        ButtonFlat {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            text: "<"
                            textColor: Material.foreground
                            onClicked: {
                                if(datePickerRoot.toDisplayMonth > 0) {
                                    datePickerRoot.toDisplayMonth --
                                } else {
                                    datePickerRoot.toDisplayMonth = 11
                                    datePickerRoot.toDisplayYear --
                                }
                            }
                        }
                        Label {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 3
                            text: toMonthGrid.title
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 18
                        }
                        ButtonFlat {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            text: ">"
                            textColor: Material.foreground
                            onClicked: {
                                if(datePickerRoot.toDisplayMonth < 11) {
                                    datePickerRoot.toDisplayMonth ++
                                } else {
                                    datePickerRoot.toDisplayMonth = 0
                                    datePickerRoot.toDisplayYear ++
                                }
                            }
                        }
                    } // row layout title
                } // title column layout

                // TODO not working in dark theme
                DayOfWeekRow {
                    id: toDayOfWeekRow
                    Layout.column: 2
                    Layout.row: 2
                    rightPadding: 24
                    Layout.fillWidth: true
                    font.bold: false
                    delegate: LabelBodySecondary {
                        text: model.shortName
                        font: toDayOfWeekRow.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                } // day of weeks

                // TODO not working in dark theme
                WeekNumberColumn {
                    id: toWeekNumbers
                    Layout.column: 1
                    Layout.row: 3
                    Layout.fillHeight: true
                    leftPadding: 24
                    font.bold: false
                    month: datePickerRoot.toDisplayMonth
                    year: datePickerRoot.toDisplayYear
                    delegate: LabelBodySecondary {
                        text: model.weekNumber
                        font: toWeekNumbers.font
                        //font.bold: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                } // WeekNumberColumn


                MonthGrid {
                    id: toMonthGrid
                    Layout.column: 2
                    Layout.row: 3
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    rightPadding: 24

                    month: datePickerRoot.toDisplayMonth
                    year: datePickerRoot.toDisplayYear

                    // ATTENTION: on Qt 5.9 clicked signal only if clicked with mouse
                    // no event if tapped on a day
                    // https://bugreports.qt.io/browse/QTBUG-61585
                    // fixed in 5.9.2
                    // so as a woraround I added a MouseArea for the delegate Label
                    //            onClicked: {
                    //                // Important: check the month to avoid clicking on days outside where opacity 0
                    //                if(date.getMonth() == datePickerRoot.toDisplayMonth) {
                    //                    datePickerRoot.toSelectedDate = date
                    //                    console.log("tapped on a date ")
                    //                } else {
                    //                    console.log("outside valid month "+date.getMonth())
                    //                }
                    //            }

                    delegate: Label {
                        id: toDayLabel
                        readonly property bool selected: model.day === datePickerRoot.toSelectedDate.getDate()
                                                         && model.month === datePickerRoot.toSelectedDate.getMonth()
                                                         && model.year === datePickerRoot.toSelectedDate.getFullYear()
                        text: model.day
                        font.bold: model.today? true: false
                        opacity: model.month === toMonthGrid.month ? 1 : 0
                        color: pressed || selected ? Material.primary : model.today ? Material.accent : Material.foreground
                        minimumPointSize: 8
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        background: Rectangle {
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 1.2
                            height: width
                            radius: width / 2
                            //                    color: primaryColor
                            visible: pressed || parent.selected
                        }
                        // WORKAROUND !! see onClicked()
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("mouse as click")
                                // Important: check the month to avoid clicking on days outside where opacity 0
                                if(date.getMonth() === datePickerRoot.toDisplayMonth) {
                                    datePickerRoot.toSelectedDate = date
                                    console.log("tapped on a date ")
                                } else {
                                    console.log("outside valid month "+date.getMonth())
                                }
                            }
                        } // mouse
                    } // label in month grid
                } // month grid
            } // grid layout
        }

        ColumnLayout {
            id: toFooter
            Layout.fillWidth: true
            RowLayout {
                ButtonFlat {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 3
                    text: qsTr("Today")
                    //                    textColor: accentColor
                    textColor: Material.accent
                    onClicked: {
                        datePickerRoot.fromSelectedDate = new Date()
                        datePickerRoot.fromDisplayMonth = datePickerRoot.toSelectedDate.getMonth()
                        datePickerRoot.fromDisplayYear = datePickerRoot.toSelectedDate.getFullYear()

                        datePickerRoot.toSelectedDate = new Date()
                        datePickerRoot.toDisplayMonth = datePickerRoot.toSelectedDate.getMonth()
                        datePickerRoot.toDisplayYear = datePickerRoot.toSelectedDate.getFullYear()
                    }
                } // cancel button
                ButtonFlat {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 3
                    text: qsTr("Cancel")
                    textColor: Material.color(Material.Grey)
                    onClicked: {
                        datePickerRoot.close()
                    }
                } // cancel button
                ButtonFlat {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 2
                    text: qsTr("OK")
                    textColor: Material.color(Material.Green)
                    onClicked: {
                        datePickerRoot.isOK = true
                        datePickerRoot.close()
                    }
                } // ok button
            }
        } // footer buttons
    }

    onOpened: {
        datePickerRoot.isOK = false
    }
} // popup calendar
