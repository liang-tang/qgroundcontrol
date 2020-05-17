/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtLocation       5.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs  1.2
import QtQuick.Layouts  1.2

import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Palette       1.0
import QGroundControl               1.0


/// Marker for displaying a camera trigger on the map
MapQuickItem {
    anchorPoint.x:  sourceItem.width / 2
    anchorPoint.y:  sourceItem.height / 2
    //property var    _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle ? QGroundControl.multiVehicleManager.activeVehicle : QGroundControl.multiVehicleManager.offlineEditingVehicle
    //property var    color1:          //_activeVehicle.waterQuality.temp.rawValue > 20?"green":"red"
    property var    color1                                                  ///< Map control to place item in

    // Extra circle to indicate selection
    sourceItem: Rectangle {
        width:          15
        height:         15
        radius:         7.5
        color:          color1
        border.color:   Qt.rgba(1,1,1,0.5)
        border.width:   1
        visible:        true
        //anchors.centerIn: indicator
    }

    // sourceItem: Rectangle {
    //     width:      _radius * 2
    //     height:     _radius * 2
    //     radius:     _radius
    //     color:      "black"
    //     opacity:    0.4

    //     readonly property real _radius: ScreenTools.defaultFontPixelHeight * 0.6

    //     QGCColoredImage {
    //         anchors.margins:    3
    //         anchors.fill:       parent
    //         color:              "white"
    //         //mipmap:             true
    //         //fillMode:           Image.PreserveAspectFit
    //         source:             "/res/cancel.svg"
    //     }
    // }
}
