/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Dialogs  1.2
import QtQuick.Layouts  1.2

import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Palette       1.0
import QGroundControl               1.0

/// Value page for InstrumentPanel PageView
Column {
    id:         _largeColumn
    width:      pageWidth
    spacing:    _margins

    property bool showSettingsIcon: true

    property var    _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle ? QGroundControl.multiVehicleManager.activeVehicle : QGroundControl.multiVehicleManager.offlineEditingVehicle
    property real   _margins:       ScreenTools.defaultFontPixelWidth / 2

    QGCPalette { id:qgcPal; colorGroupEnabled: true }

    ValuesWidgetController {
        id: controller
    }

    function showSettings() {
        mainWindow.showComponentDialog(propertyPicker, qsTr("Value Widget Setup"), mainWindow.showDialogDefaultWidth, StandardButton.Ok)
    }

    function listContains(list, value) {
        for (var i=0; i<list.length; i++) {
            if (list[i] === value) {
                return true
            }
        }
        return false
    }

    Repeater {
        model: _activeVehicle ? controller.largeValues : 0
        Loader {
            sourceComponent: fact ? largeValue : undefined
            property Fact fact: _activeVehicle.getFact(modelData.replace("Vehicle.", ""))
        }
    } // Repeater - Large

    Flow {
        id:                 _smallFlow
        width:              parent.width
        layoutDirection:    Qt.LeftToRight
        spacing:            _margins

        Repeater {
            model: _activeVehicle ? controller.smallValues : 0
            Loader {
                sourceComponent: fact ? smallValue : undefined
                property Fact fact: _activeVehicle.getFact(modelData.replace("Vehicle.", ""))
            }
        } // Repeater - Small
    } // Flow

    Component {
        id: largeValue

        Column {
            width:  _largeColumn.width
            property bool largeValue: listContains(controller.altitudeProperties, fact.name)

            QGCLabel {
                width:                  parent.width
                horizontalAlignment:    Text.AlignHCenter
                wrapMode:               Text.WordWrap
                text:                   fact.shortDescription + (fact.units ? " (" + fact.units + ")" : "")
            }
            QGCLabel {
                width:                  parent.width
                horizontalAlignment:    Text.AlignHCenter
                font.pointSize:         ScreenTools.mediumFontPointSize * (largeValue ? 1.3 : 1.0)
                font.family:            largeValue ? ScreenTools.demiboldFontFamily : ScreenTools.normalFontFamily
                fontSizeMode:           Text.HorizontalFit
                text:                   fact.enumOrValueString
            }
        }
    }

    Component {
        id: smallValue

        Column {
            width:  (pageWidth / 2) - (_margins / 2) - 0.1
            clip:   true

            QGCLabel {
                width:                  parent.width
                wrapMode:               Text.WordWrap
                horizontalAlignment:    Text.AlignHCenter
                font.pointSize:         ScreenTools.isTinyScreen ? ScreenTools.smallFontPointSize * 0.75 : ScreenTools.smallFontPointSize
                text:                   fact.shortDescription
            }
            QGCLabel {
                width:                  parent.width
                horizontalAlignment:    Text.AlignHCenter
                fontSizeMode:           Text.HorizontalFit
                text:                   fact.enumOrValueString
            }
            QGCLabel {
                width:                  parent.width
                horizontalAlignment:    Text.AlignHCenter
                font.pointSize:         ScreenTools.isTinyScreen ? ScreenTools.smallFontPointSize * 0.75 : ScreenTools.smallFontPointSize
                fontSizeMode:           Text.HorizontalFit
                text:                   fact.units
            }
        }
    }

    Component {
        id: propertyPicker

        QGCViewDialog {
            id: _propertyPickerDialog

            QGCFlickable {
                anchors.fill:       parent
                contentHeight:      column.height
                flickableDirection: Flickable.VerticalFlick
                clip:               true

                Column {
                    id:             column
                    anchors.left:   parent.left
                    anchors.right:  parent.right
                    spacing:        _margins

                    /*
                      Leaving this here for now just in case
                    FactCheckBox {
                        text:       qsTr("Show large compass")
                        fact:       _showLargeCompass
                        visible:    _showLargeCompass.visible

                        property Fact _showLargeCompass: QGroundControl.settingsManager.appSettings.showLargeCompass
                    }
                    */

                    Item {
                        width:  1
                        height: _margins
                    }

                    QGCLabel {
                        id:     _label
                        anchors.left:   parent.left
                        anchors.right:  parent.right
                        wrapMode:       Text.WordWrap
                        text:   qsTr("Select the values you want to display:")
                    }

                    Loader {
                        anchors.left:       parent.left
                        anchors.right:      parent.right
                        sourceComponent:    factGroupList

                        property var    factGroup:     _activeVehicle
                        property string factGroupName: "Vehicle"
                    }

                    Repeater {
                        model: _activeVehicle.factGroupNames

                        Loader {
                            anchors.left:       parent.left
                            anchors.right:      parent.right
                            sourceComponent:    factGroupList

                            property var    factGroup:     _activeVehicle.getFactGroup(modelData)
                            property string factGroupName: modelData
                        }

                    }
                }
            }
        }
    }

    Component {
        id: factGroupList

        // You must push in the following properties from the Loader
        // property var factGroup
        // property string factGroupName

        Column {
            spacing:    _margins

            SectionHeader {
                id:             header
                anchors.left:   parent.left
                anchors.right:  parent.right
                text:           factGroupName.charAt(0).toUpperCase() + factGroupName.slice(1)
                checked:        false
            }

            Column {
                spacing:    _margins
                visible:    header.checked

                Repeater {
                    model: factGroup ? factGroup.factNames : 0

                    RowLayout {
                        spacing: _margins
                        visible: factGroup.getFact(modelData).shortDescription !== ""

                        property string propertyName: factGroupName + "." + modelData

                        function removeFromList(list, value) {
                            var newList = []
                            for (var i=0; i<list.length; i++) {
                                if (list[i] !== value) {
                                    newList.push(list[i])
                                }
                            }
                            return newList
                        }

                        function addToList(list, value) {
                            var found = false
                            for (var i=0; i<list.length; i++) {
                                if (list[i] === value) {
                                    found = true
                                    break
                                }
                            }
                            if (!found) {
                                list.push(value)
                            }
                            return list
                        }

                        function updateValues() {
                            if (_addCheckBox.checked) {
                                if (_largeCheckBox.checked) {
                                    controller.largeValues = addToList(controller.largeValues, propertyName)
                                    controller.smallValues = removeFromList(controller.smallValues, propertyName)
                                } else {
                                    controller.smallValues = addToList(controller.smallValues, propertyName)
                                    controller.largeValues = removeFromList(controller.largeValues, propertyName)
                                }
                            } else {
                                controller.largeValues = removeFromList(controller.largeValues, propertyName)
                                controller.smallValues = removeFromList(controller.smallValues, propertyName)
                            }
                            if (listContains(controller.smallValues, "waterQuality.cod") || listContains(controller.largeValues, "waterQuality.cod")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x1
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffffe
                            }
                            if (listContains(controller.smallValues, "waterQuality.toc") || listContains(controller.largeValues, "waterQuality.toc")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x2
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffffd
                            }
                            if (listContains(controller.smallValues, "waterQuality.nh3n") || listContains(controller.largeValues, "waterQuality.nh3n")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x4
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffffb
                            }
                            if (listContains(controller.smallValues, "waterQuality.ldo") || listContains(controller.largeValues, "waterQuality.ldo")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x8
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffff7
                            }
                            if (listContains(controller.smallValues, "waterQuality.turb") || listContains(controller.largeValues, "waterQuality.turb")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x10
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xffffffef
                            }
                            if (listContains(controller.smallValues, "waterQuality.cond") || listContains(controller.largeValues, "waterQuality.cond")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x20
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xffffffdf
                            }
                            if (listContains(controller.smallValues, "waterQuality.ph") || listContains(controller.largeValues, "waterQuality.ph")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x40
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xffffffbf
                            }
                            if (listContains(controller.smallValues, "waterQuality.orp") || listContains(controller.largeValues, "waterQuality.orp")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x80
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xffffff7f
                            }
                            if (listContains(controller.smallValues, "waterQuality.chla") || listContains(controller.largeValues, "waterQuality.chla")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x100
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffeff
                            }
                            if (listContains(controller.smallValues, "waterQuality.cyano") || listContains(controller.largeValues, "waterQuality.cyano")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x200
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffdff
                            }
                            if (listContains(controller.smallValues, "waterQuality.oil") || listContains(controller.largeValues, "waterQuality.oil")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x400
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffffbff
                            }
                            if (listContains(controller.smallValues, "waterQuality.temp") || listContains(controller.largeValues, "waterQuality.temp")) {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue |= 0x800
                            } else {
                                QGroundControl.settingsManager.appSettings.wqDataSelected.rawValue &= 0xfffff7ff
                            }
                        }

                        QGCCheckBox {
                            id:                     _addCheckBox
                            text:                   factGroup.getFact(modelData).shortDescription
                            checked:                listContains(controller.smallValues, propertyName) || _largeCheckBox.checked
                            onClicked:              updateValues()
                            Layout.fillWidth:       true
                            Layout.minimumWidth:    ScreenTools.defaultFontPixelWidth * 20

                            Component.onCompleted: {
                                if (checked) {
                                    header.checked = true
                                }
                            }
                        }

                        QGCCheckBox {
                            id:                     _largeCheckBox
                            text:                   qsTr("Large")
                            checked:                listContains(controller.largeValues, propertyName)
                            enabled:                _addCheckBox.checked
                            onClicked:              updateValues()
                        }
                    }
                }
            }
        }
    }

    function getFactFunction(index) {
        var dataType = QGroundControl.settingsManager.appSettings.wqDataType.rawValue

        if (dataType === 0) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain01
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain02
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain03
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain04
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain05
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain06
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain07
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain08
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain09
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain010
        } else if (dataType === 1) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain11
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain12
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain13
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain14
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain15
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain16
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain17
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain18
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain19
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain110
        } else if (dataType === 2) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain21
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain22
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain23
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain24
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain25
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain26
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain27
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain28
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain29
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain210
        } else if (dataType === 3) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain31
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain32
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain33
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain34
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain35
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain36
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain37
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain38
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain39
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain310
        } else if (dataType === 4) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain41
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain42
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain43
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain44
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain45
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain46
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain47
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain48
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain49
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain410
        } else if (dataType === 5) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain51
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain52
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain53
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain54
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain55
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain56
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain57
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain58
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain59
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain510
        } else if (dataType === 6) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain61
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain62
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain63
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain64
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain65
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain66
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain67
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain68
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain69
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain610
        } else if (dataType === 7) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain71
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain72
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain73
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain74
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain75
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain76
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain77
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain78
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain79
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain710
        } else if (dataType === 8) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain81
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain82
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain83
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain84
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain85
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain86
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain87
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain88
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain89
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain810
        } else if (dataType === 9) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain91
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain92
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain93
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain94
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain95
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain96
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain97
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain98
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain99
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain910
        } else if (dataType === 10) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain101
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain102
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain103
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain104
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain105
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain106
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain107
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain108
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain109
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain1010
        } else if (dataType === 11) {
            if (index === 1)
                return QGroundControl.settingsManager.appSettings.domain111
            else if (index === 2)
                return QGroundControl.settingsManager.appSettings.domain112
            else if (index === 3)
                return QGroundControl.settingsManager.appSettings.domain113
            else if (index === 4)
                return QGroundControl.settingsManager.appSettings.domain114
            else if (index === 5)
                return QGroundControl.settingsManager.appSettings.domain115
            else if (index === 6)
                return QGroundControl.settingsManager.appSettings.domain116
            else if (index === 7)
                return QGroundControl.settingsManager.appSettings.domain117
            else if (index === 8)
                return QGroundControl.settingsManager.appSettings.domain118
            else if (index === 9)
                return QGroundControl.settingsManager.appSettings.domain119
            else if (index === 10)
                return QGroundControl.settingsManager.appSettings.domain1110
        }
    }

    RowLayout {
        spacing: 10

        QGCLabel {
            text:               qsTr("Dist")
            visible:            true
        }

        QGCTextField {
            id:                 dist
            width:              12
            text:               qsTr("0.0")
            unitsLabel:         qsTr("m")
            showUnits:          true
            //maximumLength:      5
        }
    }

    QGCButton {
        anchors.horizontalCenter:   parent.horizontalCenter
        text:               qsTr("Start")
        visible:            true
        onClicked:          confirmStart.open()
        enabled:            activeVehicle

        MessageDialog {
            id:                 confirmStart
            visible:            false
            icon:               StandardIcon.NoIcon
            standardButtons:    StandardButton.Yes | StandardButton.No
            title:              qsTr("Start")
            text:               qsTr("Are you sure to Start?")
            onYes: {
                activeVehicle.setParam(1, "WQ_TRIGG_DIST", parseFloat(dist.text))
                confirmStart.close()
            }
            onNo: {
                confirmStart.close()
            }
        }
    }

    QGCButton {
        anchors.horizontalCenter:   parent.horizontalCenter
        text:               qsTr("Stop")
        visible:            true
        onClicked:          confirmStop.open()
        enabled:            activeVehicle

        MessageDialog {
            id:                 confirmStop
            visible:            false
            icon:               StandardIcon.NoIcon
            standardButtons:    StandardButton.Yes | StandardButton.No
            title:              qsTr("Stop")
            text:               qsTr("Are you sure to Stop?")
            onYes: {
                activeVehicle.setParam(1, "WQ_TRIGG_DIST", 0)
                confirmStop.close()
            }
            onNo: {
                confirmStop.close()
            }
        }
    }

    QGCButton {
        anchors.horizontalCenter:   parent.horizontalCenter
        text:                       qsTr("Once")
        visible:                    true
        onClicked:                  activeVehicle.triggerWq()
        enabled:                    activeVehicle
    }

    RowLayout {
        spacing: 10

        QGCLabel {
            text:               qsTr("Show")
            visible:            true
        }
        FactComboBox {
            fact:               QGroundControl.settingsManager.appSettings.wqDataType
            indexModel:         false
        }
    }

    RowLayout {
        spacing: 2

        QGCLabel {
            text:                   qsTr("domain1")
        }

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(1)
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        Rectangle {
            width:  ScreenTools.defaultFontPixelWidth * 3
            height: ScreenTools.defaultFontPixelHeight * 1.5
            color:  "#00e04b"
        }

        Text { text: " <"; font.bold: true; color: "white"}

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(2)
        }
    }

    RowLayout {
        spacing: 2

        QGCLabel {
            text:                   qsTr("domain2")
        }

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(3)
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        Rectangle {
            width:  ScreenTools.defaultFontPixelWidth * 3
            height: ScreenTools.defaultFontPixelHeight * 1.5
            color:  "#de8500"
        }

        Text { text: " <"; font.bold: true; color: "white"}

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(4)
        }
    }

    RowLayout {
        spacing: 2

        QGCLabel {
            text:                   qsTr("domain3")
        }

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(5)
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        Rectangle {
            width:  ScreenTools.defaultFontPixelWidth * 3
            height: ScreenTools.defaultFontPixelHeight * 1.5
            color:  "#536dff"
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(6)
        }
    }

    RowLayout {
        spacing: 2

        QGCLabel {
            text:                   qsTr("domain4")
        }

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(7)
        }

        Text { text: "< "; font.bold: true; color: "white"}

        Rectangle {
            width:  ScreenTools.defaultFontPixelWidth * 3
            height: ScreenTools.defaultFontPixelHeight * 1.5
            color:  "#f85761"
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(8)
        }
    }

    RowLayout {
        spacing: 2

        QGCLabel {
            text:                   qsTr("domain5")
        }

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(9)
        }

        Text { text: "< "; font.bold: true; color: "white"}

        Rectangle {
            width:  ScreenTools.defaultFontPixelWidth * 3
            height: ScreenTools.defaultFontPixelHeight * 1.5
            color:  "#e10f3f"
        }

        Text { text: "≤"; font.bold: true; color: "white"}

        FactTextField {
            Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 7
            fact:                   getFactFunction(10)
        }
    }
}
