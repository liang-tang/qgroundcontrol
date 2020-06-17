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

import QGroundControl.ScreenTools   1.0
import QGroundControl.Controls      1.0
import QGroundControl.Vehicle       1.0

/// Marker for displaying a camera trigger on the map
MapQuickItem {
    anchorPoint.x:  sourceItem.anchorPointX
    anchorPoint.y:  sourceItem.anchorPointY
    property var    color1                                                  ///< Map control to place item in
    property var    index1
    property var    value1

    sourceItem: MissionItemIndexLabel {
        checked:    false
        highlightSelected:  true
        color:      color1
        onClicked: guidedActionsController.confirmAction(guidedActionsController.actionShow, value1)
    }
}
