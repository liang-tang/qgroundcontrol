/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


import QtQuick 2.3

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FlightMap     1.0
import QGroundControl.Palette       1.0

Rectangle {
    id:             root
    width:          getPreferredInstrumentWidth()
    height:         _outerRadius * 10
    radius:         _outerRadius
    color:          qgcPal.window
    border.width:   1
    border.color:   _isSatellite ? qgcPal.mapWidgetBorderLight : qgcPal.mapWidgetBorderDark

    property var    _qgcView:           qgcView
    property real   _innerRadius:       (width - (_topBottomMargin * 3)) / 4
    property real   _outerRadius:       _innerRadius + _topBottomMargin
    property real   _defaultSize:       ScreenTools.defaultFontPixelHeight * (9)
    property real   _sizeRatio:         ScreenTools.isTinyScreen ? (width / _defaultSize) * 0.5 : width / _defaultSize
    property real   _bigFontSize:       ScreenTools.defaultFontPointSize * 2.5  * _sizeRatio
    property real   _normalFontSize:    ScreenTools.defaultFontPointSize * 1.5  * _sizeRatio
    property real   _labelFontSize:     ScreenTools.defaultFontPointSize * 0.75 * _sizeRatio
    property real   _spacing:           ScreenTools.defaultFontPixelHeight * 0.33
    property real   _topBottomMargin:   (width * 0.05) / 2
    property real   _availableValueHeight: maxHeight - (root.height + _valuesItem.anchors.topMargin)
    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle

    // Prevent all clicks from going through to lower layers
    DeadMouseArea {
        anchors.fill: parent
    }

    QGCPalette { id: qgcPal }

    QGCAttitudeWidget {
        id:                 attitude
        anchors.leftMargin: _topBottomMargin
        anchors.left:       parent.left
        anchors.topMargin: _topBottomMargin
        anchors.top:        parent.top
        size:               _innerRadius * 2
        vehicle:            _activeVehicle
    }

    QGCCompassWidget {
        id:                 compass
        anchors.leftMargin: _spacing
        anchors.left:       attitude.right
        anchors.topMargin: _topBottomMargin
        anchors.top:        parent.top
        size:               _innerRadius * 2
        vehicle:            _activeVehicle
    }

    QGCWindAngleWidget {
        id:                 windangle
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin: _topBottomMargin
        anchors.top:        attitude.bottom
        size:               _innerRadius * 2
        vehicle:            _activeVehicle
    }

    QGCLabel {
        id:                 windvane_wind_speed_horiz
        anchors.leftMargin: _spacing
        anchors.left:       windangle.right
        anchors.topMargin:  _topBottomMargin + sensorver.height / 2
        anchors.top:        attitude.bottom
        text:               "WHor"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _spacing
        anchors.left:      windvane_wind_speed_horiz.right
        anchors.topMargin: _topBottomMargin + sensorver.height / 2
        anchors.top:        attitude.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               _windvane_wind_speed_horizString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string _windvane_wind_speed_horizString: _activeVehicle ? _activeVehicle.windvane_wind_speed_horiz.rawValue.toFixed(1) : "0"
        }
    }

    QGCSensorHorWidget{
        id:                 sensorhor
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin: _topBottomMargin
        anchors.top:        windangle.bottom
        size:               _innerRadius * 2
        vehicle:            _activeVehicle
    }

    QGCLabel {
        id:                 windvane_speed_horiz_sensor
        anchors.leftMargin: _topBottomMargin
        anchors.left:       sensorhor.right
        anchors.topMargin: _topBottomMargin + sensorver.height / 2
        anchors.top:        windangle.bottom
        text:               "SHor"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _topBottomMargin
        anchors.left:       windvane_speed_horiz_sensor.right
        anchors.topMargin: _topBottomMargin + sensorver.height / 2
        anchors.top:        windangle.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               _windvane_wind_speed_horizString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string _windvane_wind_speed_horizString: _activeVehicle ? _activeVehicle.windvane_speed_horiz_sensor.rawValue.toFixed(1) : "0"
        }
    }

    QGCSensorVerWidget{
        id:                 sensorver
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin:  _topBottomMargin
        anchors.top:        sensorhor.bottom
        size:               _innerRadius * 2
        vehicle:            _activeVehicle
    }

    QGCLabel {
        id:                 windvane_speed_vert_sensor
        anchors.leftMargin: _spacing
        anchors.left:       sensorver.right
        anchors.topMargin:  _topBottomMargin + sensorver.height / 2
        anchors.top:        sensorhor.bottom
        text:               "SVer"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _topBottomMargin
        anchors.left:       windvane_speed_vert_sensor.right
        anchors.topMargin: _topBottomMargin + sensorver.height / 2
        anchors.top:        sensorhor.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               _windvane_wind_speed_horizString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string _windvane_wind_speed_horizString: _activeVehicle ? _activeVehicle.windvane_speed_vert_sensor.rawValue.toFixed(1) : "0"
        }
    }

    QGCLabel {
        id:                 windvane_wind_speed_3d_x
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin:  _topBottomMargin
        anchors.top:        sensorver.bottom
        text:               "Vwx"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _spacing
        anchors.left:       windvane_wind_speed_3d_x.right
        anchors.topMargin: _topBottomMargin
        anchors.top:        sensorver.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               _windvane_wind_speed_3d_xString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string _windvane_wind_speed_3d_xString: _activeVehicle ? _activeVehicle.windvane_wind_speed_3d_x.rawValue.toFixed(1) : "0"
        }
    }

    QGCLabel {
        id:                 windvane_wind_speed_3d_y
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin:  _topBottomMargin
        anchors.top:        windvane_wind_speed_3d_x.bottom
        text:               "Vwy"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _spacing
        anchors.left:      windvane_wind_speed_3d_y.right
        anchors.topMargin: _topBottomMargin
        anchors.top:        windvane_wind_speed_3d_x.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               windvane_wind_speed_3d_yString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string windvane_wind_speed_3d_yString: _activeVehicle ? _activeVehicle.windvane_wind_speed_3d_y.rawValue.toFixed(1) : "0"
        }
    }

    QGCLabel {
        id:                 windvane_wind_speed_3d_z
        anchors.leftMargin: _spacing
        anchors.left:       parent.left
        anchors.topMargin:  _topBottomMargin
        anchors.top:        windvane_wind_speed_3d_y.bottom
        text:               "Vwz"
        font.family:        ScreenTools.normalFontFamily
        font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
        color:              qgcPal.text
    }

    Rectangle {
        anchors.leftMargin: _spacing
        anchors.left:      windvane_wind_speed_3d_z.right
        anchors.topMargin: _topBottomMargin
        anchors.top:        windvane_wind_speed_3d_y.bottom
        width:              _defaultSize * 0.35
        height:             _defaultSize * 0.2
        border.color:       qgcPal.text
        color:              qgcPal.window
        opacity:            0.65

        QGCLabel {
            text:               _windvane_wind_speed_3d_zString
            font.family:        ScreenTools.normalFontFamily
            font.pointSize:     ScreenTools.defaultFontPointSize * _sizeRatio < 8 ? 8 : ScreenTools.defaultFontPointSize * _sizeRatio;
            color:              qgcPal.text
            anchors.centerIn:   parent

            property string _windvane_wind_speed_3d_zString: _activeVehicle ? _activeVehicle.windvane_wind_speed_3d_z.rawValue.toFixed(1) : "0"
        }
    }

    Item {
        id:                 _valuesItem
        anchors.topMargin:  ScreenTools.defaultFontPixelHeight / 4
        anchors.top:        parent.bottom
        width:              parent.width
        height:             _valuesWidget.height
        visible:            widgetRoot.showValues

        // Prevent all clicks from going through to lower layers
        DeadMouseArea {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill:   _valuesWidget
            color:          qgcPal.window
        }

        PageView {
            id:                 _valuesWidget
            anchors.margins:    1
            anchors.left:       parent.left
            anchors.right:      parent.right
            qgcView:            root._qgcView
            maxHeight:          _availableValueHeight
        }
    }
}
