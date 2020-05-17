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
   // anchorPoint.x:  sourceItem.width
//    anchorPoint.y:  sourceItem.height
    anchorPoint.x:  sourceItem.anchorPointX
    anchorPoint.y:  sourceItem.anchorPointY
    //property var    _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle ? QGroundControl.multiVehicleManager.activeVehicle : QGroundControl.multiVehicleManager.offlineEditingVehicle
    //property var    color1:          //_activeVehicle.waterQuality.temp.rawValue > 20?"green":"red"
    property var    color1                                                  ///< Map control to place item in
    property var    index1

    sourceItem: MissionItemIndexLabel {
        checked:    true
        index:      index1
        label:      qsTr("Go here")
    }
}
