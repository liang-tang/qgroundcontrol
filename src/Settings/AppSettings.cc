/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#include "AppSettings.h"
#include "QGCPalette.h"
#include "QGCApplication.h"
#include "ParameterManager.h"

#include <QQmlEngine>
#include <QtQml>
#include <QStandardPaths>

const char* AppSettings::parameterFileExtension =   "params";
const char* AppSettings::planFileExtension =        "plan";
const char* AppSettings::missionFileExtension =     "mission";
const char* AppSettings::waypointsFileExtension =   "waypoints";
const char* AppSettings::fenceFileExtension =       "fence";
const char* AppSettings::rallyPointFileExtension =  "rally";
const char* AppSettings::telemetryFileExtension =   "tlog";
const char* AppSettings::kmlFileExtension =         "kml";
const char* AppSettings::shpFileExtension =         "shp";
const char* AppSettings::logFileExtension =         "ulg";

const char* AppSettings::parameterDirectory =       "Parameters";
const char* AppSettings::telemetryDirectory =       "Telemetry";
const char* AppSettings::missionDirectory =         "Missions";
const char* AppSettings::logDirectory =             "Logs";
const char* AppSettings::videoDirectory =           "Video";
const char* AppSettings::crashDirectory =           "CrashLogs";

DECLARE_SETTINGGROUP(App, "")
{
    qmlRegisterUncreatableType<AppSettings>("QGroundControl.SettingsManager", 1, 0, "AppSettings", "Reference only");
    QGCPalette::setGlobalTheme(indoorPalette()->rawValue().toBool() ? QGCPalette::Dark : QGCPalette::Light);

    // Instantiate savePath so we can check for override and setup default path if needed

    SettingsFact* savePathFact = qobject_cast<SettingsFact*>(savePath());
    QString appName = qgcApp()->applicationName();
    if (savePathFact->rawValue().toString().isEmpty() && _nameToMetaDataMap[savePathName]->rawDefaultValue().toString().isEmpty()) {
#ifdef __mobile__
#ifdef __ios__
        QDir rootDir = QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
#else
        QDir rootDir = QDir(QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation));
#endif
        savePathFact->setVisible(false);
#else
        QDir rootDir = QDir(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
#endif
        savePathFact->setRawValue(rootDir.filePath(appName));
    }

    connect(savePathFact, &Fact::rawValueChanged, this, &AppSettings::savePathsChanged);
    connect(savePathFact, &Fact::rawValueChanged, this, &AppSettings::_checkSavePathDirectories);

    _checkSavePathDirectories();
    //-- Keep track of language changes
    SettingsFact* languageFact = qobject_cast<SettingsFact*>(language());
    connect(languageFact, &Fact::rawValueChanged, this, &AppSettings::_languageChanged);
}

DECLARE_SETTINGSFACT(AppSettings, offlineEditingFirmwareType)
DECLARE_SETTINGSFACT(AppSettings, offlineEditingVehicleType)
DECLARE_SETTINGSFACT(AppSettings, offlineEditingCruiseSpeed)
DECLARE_SETTINGSFACT(AppSettings, offlineEditingHoverSpeed)
DECLARE_SETTINGSFACT(AppSettings, offlineEditingAscentSpeed)
DECLARE_SETTINGSFACT(AppSettings, offlineEditingDescentSpeed)
DECLARE_SETTINGSFACT(AppSettings, batteryPercentRemainingAnnounce)
DECLARE_SETTINGSFACT(AppSettings, defaultMissionItemAltitude)
DECLARE_SETTINGSFACT(AppSettings, telemetrySave)
DECLARE_SETTINGSFACT(AppSettings, telemetrySaveNotArmed)
DECLARE_SETTINGSFACT(AppSettings, audioMuted)
DECLARE_SETTINGSFACT(AppSettings, checkInternet)
DECLARE_SETTINGSFACT(AppSettings, virtualJoystick)
DECLARE_SETTINGSFACT(AppSettings, virtualJoystickCentralized)
DECLARE_SETTINGSFACT(AppSettings, appFontPointSize)
DECLARE_SETTINGSFACT(AppSettings, showLargeCompass)
DECLARE_SETTINGSFACT(AppSettings, savePath)
DECLARE_SETTINGSFACT(AppSettings, autoLoadMissions)
DECLARE_SETTINGSFACT(AppSettings, useChecklist)
DECLARE_SETTINGSFACT(AppSettings, enforceChecklist)
DECLARE_SETTINGSFACT(AppSettings, mapboxToken)
DECLARE_SETTINGSFACT(AppSettings, esriToken)
DECLARE_SETTINGSFACT(AppSettings, defaultFirmwareType)
DECLARE_SETTINGSFACT(AppSettings, gstDebugLevel)
DECLARE_SETTINGSFACT(AppSettings, followTarget)
DECLARE_SETTINGSFACT(AppSettings, apmStartMavlinkStreams)
DECLARE_SETTINGSFACT(AppSettings, enableTaisync)
DECLARE_SETTINGSFACT(AppSettings, enableTaisyncVideo)
DECLARE_SETTINGSFACT(AppSettings, enableMicrohard)
DECLARE_SETTINGSFACT(AppSettings, language)
DECLARE_SETTINGSFACT(AppSettings, disableAllPersistence)
DECLARE_SETTINGSFACT(AppSettings, usePairing)
DECLARE_SETTINGSFACT(AppSettings, saveCsvTelemetry)
DECLARE_SETTINGSFACT(AppSettings, wqDataType)

DECLARE_SETTINGSFACT(AppSettings, domain01)
DECLARE_SETTINGSFACT(AppSettings, domain02)
DECLARE_SETTINGSFACT(AppSettings, domain03)
DECLARE_SETTINGSFACT(AppSettings, domain04)
DECLARE_SETTINGSFACT(AppSettings, domain05)
DECLARE_SETTINGSFACT(AppSettings, domain06)
DECLARE_SETTINGSFACT(AppSettings, domain07)
DECLARE_SETTINGSFACT(AppSettings, domain08)
DECLARE_SETTINGSFACT(AppSettings, domain09)
DECLARE_SETTINGSFACT(AppSettings, domain010)

DECLARE_SETTINGSFACT(AppSettings, domain11)
DECLARE_SETTINGSFACT(AppSettings, domain12)
DECLARE_SETTINGSFACT(AppSettings, domain13)
DECLARE_SETTINGSFACT(AppSettings, domain14)
DECLARE_SETTINGSFACT(AppSettings, domain15)
DECLARE_SETTINGSFACT(AppSettings, domain16)
DECLARE_SETTINGSFACT(AppSettings, domain17)
DECLARE_SETTINGSFACT(AppSettings, domain18)
DECLARE_SETTINGSFACT(AppSettings, domain19)
DECLARE_SETTINGSFACT(AppSettings, domain110)

DECLARE_SETTINGSFACT(AppSettings, domain21)
DECLARE_SETTINGSFACT(AppSettings, domain22)
DECLARE_SETTINGSFACT(AppSettings, domain23)
DECLARE_SETTINGSFACT(AppSettings, domain24)
DECLARE_SETTINGSFACT(AppSettings, domain25)
DECLARE_SETTINGSFACT(AppSettings, domain26)
DECLARE_SETTINGSFACT(AppSettings, domain27)
DECLARE_SETTINGSFACT(AppSettings, domain28)
DECLARE_SETTINGSFACT(AppSettings, domain29)
DECLARE_SETTINGSFACT(AppSettings, domain210)

DECLARE_SETTINGSFACT(AppSettings, domain31)
DECLARE_SETTINGSFACT(AppSettings, domain32)
DECLARE_SETTINGSFACT(AppSettings, domain33)
DECLARE_SETTINGSFACT(AppSettings, domain34)
DECLARE_SETTINGSFACT(AppSettings, domain35)
DECLARE_SETTINGSFACT(AppSettings, domain36)
DECLARE_SETTINGSFACT(AppSettings, domain37)
DECLARE_SETTINGSFACT(AppSettings, domain38)
DECLARE_SETTINGSFACT(AppSettings, domain39)
DECLARE_SETTINGSFACT(AppSettings, domain310)

DECLARE_SETTINGSFACT(AppSettings, domain41)
DECLARE_SETTINGSFACT(AppSettings, domain42)
DECLARE_SETTINGSFACT(AppSettings, domain43)
DECLARE_SETTINGSFACT(AppSettings, domain44)
DECLARE_SETTINGSFACT(AppSettings, domain45)
DECLARE_SETTINGSFACT(AppSettings, domain46)
DECLARE_SETTINGSFACT(AppSettings, domain47)
DECLARE_SETTINGSFACT(AppSettings, domain48)
DECLARE_SETTINGSFACT(AppSettings, domain49)
DECLARE_SETTINGSFACT(AppSettings, domain410)

DECLARE_SETTINGSFACT(AppSettings, domain51)
DECLARE_SETTINGSFACT(AppSettings, domain52)
DECLARE_SETTINGSFACT(AppSettings, domain53)
DECLARE_SETTINGSFACT(AppSettings, domain54)
DECLARE_SETTINGSFACT(AppSettings, domain55)
DECLARE_SETTINGSFACT(AppSettings, domain56)
DECLARE_SETTINGSFACT(AppSettings, domain57)
DECLARE_SETTINGSFACT(AppSettings, domain58)
DECLARE_SETTINGSFACT(AppSettings, domain59)
DECLARE_SETTINGSFACT(AppSettings, domain510)

DECLARE_SETTINGSFACT(AppSettings, domain61)
DECLARE_SETTINGSFACT(AppSettings, domain62)
DECLARE_SETTINGSFACT(AppSettings, domain63)
DECLARE_SETTINGSFACT(AppSettings, domain64)
DECLARE_SETTINGSFACT(AppSettings, domain65)
DECLARE_SETTINGSFACT(AppSettings, domain66)
DECLARE_SETTINGSFACT(AppSettings, domain67)
DECLARE_SETTINGSFACT(AppSettings, domain68)
DECLARE_SETTINGSFACT(AppSettings, domain69)
DECLARE_SETTINGSFACT(AppSettings, domain610)

DECLARE_SETTINGSFACT(AppSettings, domain71)
DECLARE_SETTINGSFACT(AppSettings, domain72)
DECLARE_SETTINGSFACT(AppSettings, domain73)
DECLARE_SETTINGSFACT(AppSettings, domain74)
DECLARE_SETTINGSFACT(AppSettings, domain75)
DECLARE_SETTINGSFACT(AppSettings, domain76)
DECLARE_SETTINGSFACT(AppSettings, domain77)
DECLARE_SETTINGSFACT(AppSettings, domain78)
DECLARE_SETTINGSFACT(AppSettings, domain79)
DECLARE_SETTINGSFACT(AppSettings, domain710)

DECLARE_SETTINGSFACT(AppSettings, domain81)
DECLARE_SETTINGSFACT(AppSettings, domain82)
DECLARE_SETTINGSFACT(AppSettings, domain83)
DECLARE_SETTINGSFACT(AppSettings, domain84)
DECLARE_SETTINGSFACT(AppSettings, domain85)
DECLARE_SETTINGSFACT(AppSettings, domain86)
DECLARE_SETTINGSFACT(AppSettings, domain87)
DECLARE_SETTINGSFACT(AppSettings, domain88)
DECLARE_SETTINGSFACT(AppSettings, domain89)
DECLARE_SETTINGSFACT(AppSettings, domain810)

DECLARE_SETTINGSFACT(AppSettings, domain91)
DECLARE_SETTINGSFACT(AppSettings, domain92)
DECLARE_SETTINGSFACT(AppSettings, domain93)
DECLARE_SETTINGSFACT(AppSettings, domain94)
DECLARE_SETTINGSFACT(AppSettings, domain95)
DECLARE_SETTINGSFACT(AppSettings, domain96)
DECLARE_SETTINGSFACT(AppSettings, domain97)
DECLARE_SETTINGSFACT(AppSettings, domain98)
DECLARE_SETTINGSFACT(AppSettings, domain99)
DECLARE_SETTINGSFACT(AppSettings, domain910)

DECLARE_SETTINGSFACT(AppSettings, domain101)
DECLARE_SETTINGSFACT(AppSettings, domain102)
DECLARE_SETTINGSFACT(AppSettings, domain103)
DECLARE_SETTINGSFACT(AppSettings, domain104)
DECLARE_SETTINGSFACT(AppSettings, domain105)
DECLARE_SETTINGSFACT(AppSettings, domain106)
DECLARE_SETTINGSFACT(AppSettings, domain107)
DECLARE_SETTINGSFACT(AppSettings, domain108)
DECLARE_SETTINGSFACT(AppSettings, domain109)
DECLARE_SETTINGSFACT(AppSettings, domain1010)

DECLARE_SETTINGSFACT(AppSettings, domain111)
DECLARE_SETTINGSFACT(AppSettings, domain112)
DECLARE_SETTINGSFACT(AppSettings, domain113)
DECLARE_SETTINGSFACT(AppSettings, domain114)
DECLARE_SETTINGSFACT(AppSettings, domain115)
DECLARE_SETTINGSFACT(AppSettings, domain116)
DECLARE_SETTINGSFACT(AppSettings, domain117)
DECLARE_SETTINGSFACT(AppSettings, domain118)
DECLARE_SETTINGSFACT(AppSettings, domain119)
DECLARE_SETTINGSFACT(AppSettings, domain1110)

DECLARE_SETTINGSFACT_NO_FUNC(AppSettings, indoorPalette)
{
    if (!_indoorPaletteFact) {
        _indoorPaletteFact = _createSettingsFact(indoorPaletteName);
        connect(_indoorPaletteFact, &Fact::rawValueChanged, this, &AppSettings::_indoorPaletteChanged);
    }
    return _indoorPaletteFact;
}

void AppSettings::_languageChanged()
{
    qgcApp()->setLanguage();
}

void AppSettings::_checkSavePathDirectories(void)
{
    QDir savePathDir(savePath()->rawValue().toString());
    if (!savePathDir.exists()) {
        QDir().mkpath(savePathDir.absolutePath());
    }
    if (savePathDir.exists()) {
        savePathDir.mkdir(parameterDirectory);
        savePathDir.mkdir(telemetryDirectory);
        savePathDir.mkdir(missionDirectory);
        savePathDir.mkdir(logDirectory);
        savePathDir.mkdir(videoDirectory);
        savePathDir.mkdir(crashDirectory);
    }
}

void AppSettings::_indoorPaletteChanged(void)
{
    QGCPalette::setGlobalTheme(indoorPalette()->rawValue().toBool() ? QGCPalette::Dark : QGCPalette::Light);
}

QString AppSettings::missionSavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(missionDirectory);
    }
    return QString();
}

QString AppSettings::parameterSavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(parameterDirectory);
    }
    return QString();
}

QString AppSettings::telemetrySavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(telemetryDirectory);
    }
    return QString();
}

QString AppSettings::logSavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(logDirectory);
    }
    return QString();
}

QString AppSettings::videoSavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(videoDirectory);
    }
    return QString();
}

QString AppSettings::crashSavePath(void)
{
    QString path = savePath()->rawValue().toString();
    if (!path.isEmpty() && QDir(path).exists()) {
        QDir dir(path);
        return dir.filePath(crashDirectory);
    }
    return QString();
}

MAV_AUTOPILOT AppSettings::offlineEditingFirmwareTypeFromFirmwareType(MAV_AUTOPILOT firmwareType)
{
    if (firmwareType != MAV_AUTOPILOT_PX4 && firmwareType != MAV_AUTOPILOT_ARDUPILOTMEGA) {
        firmwareType = MAV_AUTOPILOT_GENERIC;
    }
    return firmwareType;
}

MAV_TYPE AppSettings::offlineEditingVehicleTypeFromVehicleType(MAV_TYPE vehicleType)
{
    if (QGCMAVLink::isRover(vehicleType)) {
        return MAV_TYPE_GROUND_ROVER;
    } else if (QGCMAVLink::isSub(vehicleType)) {
        return MAV_TYPE_SUBMARINE;
    } else if (QGCMAVLink::isVTOL(vehicleType)) {
        return MAV_TYPE_VTOL_QUADROTOR;
    } else if (QGCMAVLink::isFixedWing(vehicleType)) {
        return MAV_TYPE_FIXED_WING;
    } else {
        return MAV_TYPE_QUADROTOR;
    }
}
