/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

/// @file
/// @brief Application Settings

#pragma once
#include <QTranslator>

#include "SettingsGroup.h"
#include "QGCMAVLink.h"

/// Application Settings
class AppSettings : public SettingsGroup
{
    Q_OBJECT

public:
    AppSettings(QObject* parent = nullptr);

    DEFINE_SETTING_NAME_GROUP()

    DEFINE_SETTINGFACT(offlineEditingFirmwareType)
    DEFINE_SETTINGFACT(offlineEditingVehicleType)
    DEFINE_SETTINGFACT(offlineEditingCruiseSpeed)
    DEFINE_SETTINGFACT(offlineEditingHoverSpeed)
    DEFINE_SETTINGFACT(offlineEditingAscentSpeed)
    DEFINE_SETTINGFACT(offlineEditingDescentSpeed)
    DEFINE_SETTINGFACT(batteryPercentRemainingAnnounce)
    DEFINE_SETTINGFACT(defaultMissionItemAltitude)
    DEFINE_SETTINGFACT(telemetrySave)
    DEFINE_SETTINGFACT(telemetrySaveNotArmed)
    DEFINE_SETTINGFACT(audioMuted)
    DEFINE_SETTINGFACT(checkInternet)
    DEFINE_SETTINGFACT(virtualJoystick)
    DEFINE_SETTINGFACT(virtualJoystickCentralized)
    DEFINE_SETTINGFACT(appFontPointSize)
    DEFINE_SETTINGFACT(indoorPalette)
    DEFINE_SETTINGFACT(showLargeCompass)
    DEFINE_SETTINGFACT(savePath)
    DEFINE_SETTINGFACT(autoLoadMissions)
    DEFINE_SETTINGFACT(useChecklist)
    DEFINE_SETTINGFACT(enforceChecklist)
    DEFINE_SETTINGFACT(mapboxToken)
    DEFINE_SETTINGFACT(esriToken)
    DEFINE_SETTINGFACT(defaultFirmwareType)
    DEFINE_SETTINGFACT(gstDebugLevel)
    DEFINE_SETTINGFACT(followTarget)
    DEFINE_SETTINGFACT(enableTaisync)
    DEFINE_SETTINGFACT(enableTaisyncVideo)
    DEFINE_SETTINGFACT(enableMicrohard)
    DEFINE_SETTINGFACT(language)
    DEFINE_SETTINGFACT(disableAllPersistence)
    DEFINE_SETTINGFACT(usePairing)
    DEFINE_SETTINGFACT(saveCsvTelemetry)
    DEFINE_SETTINGFACT(wqDataType)

    DEFINE_SETTINGFACT(domain01)
    DEFINE_SETTINGFACT(domain02)
    DEFINE_SETTINGFACT(domain03)
    DEFINE_SETTINGFACT(domain04)
    DEFINE_SETTINGFACT(domain05)
    DEFINE_SETTINGFACT(domain06)
    DEFINE_SETTINGFACT(domain07)
    DEFINE_SETTINGFACT(domain08)
    DEFINE_SETTINGFACT(domain09)
    DEFINE_SETTINGFACT(domain010)

    DEFINE_SETTINGFACT(domain11)
    DEFINE_SETTINGFACT(domain12)
    DEFINE_SETTINGFACT(domain13)
    DEFINE_SETTINGFACT(domain14)
    DEFINE_SETTINGFACT(domain15)
    DEFINE_SETTINGFACT(domain16)
    DEFINE_SETTINGFACT(domain17)
    DEFINE_SETTINGFACT(domain18)
    DEFINE_SETTINGFACT(domain19)
    DEFINE_SETTINGFACT(domain110)

    DEFINE_SETTINGFACT(domain21)
    DEFINE_SETTINGFACT(domain22)
    DEFINE_SETTINGFACT(domain23)
    DEFINE_SETTINGFACT(domain24)
    DEFINE_SETTINGFACT(domain25)
    DEFINE_SETTINGFACT(domain26)
    DEFINE_SETTINGFACT(domain27)
    DEFINE_SETTINGFACT(domain28)
    DEFINE_SETTINGFACT(domain29)
    DEFINE_SETTINGFACT(domain210)

    DEFINE_SETTINGFACT(domain31)
    DEFINE_SETTINGFACT(domain32)
    DEFINE_SETTINGFACT(domain33)
    DEFINE_SETTINGFACT(domain34)
    DEFINE_SETTINGFACT(domain35)
    DEFINE_SETTINGFACT(domain36)
    DEFINE_SETTINGFACT(domain37)
    DEFINE_SETTINGFACT(domain38)
    DEFINE_SETTINGFACT(domain39)
    DEFINE_SETTINGFACT(domain310)

    DEFINE_SETTINGFACT(domain41)
    DEFINE_SETTINGFACT(domain42)
    DEFINE_SETTINGFACT(domain43)
    DEFINE_SETTINGFACT(domain44)
    DEFINE_SETTINGFACT(domain45)
    DEFINE_SETTINGFACT(domain46)
    DEFINE_SETTINGFACT(domain47)
    DEFINE_SETTINGFACT(domain48)
    DEFINE_SETTINGFACT(domain49)
    DEFINE_SETTINGFACT(domain410)

    DEFINE_SETTINGFACT(domain51)
    DEFINE_SETTINGFACT(domain52)
    DEFINE_SETTINGFACT(domain53)
    DEFINE_SETTINGFACT(domain54)
    DEFINE_SETTINGFACT(domain55)
    DEFINE_SETTINGFACT(domain56)
    DEFINE_SETTINGFACT(domain57)
    DEFINE_SETTINGFACT(domain58)
    DEFINE_SETTINGFACT(domain59)
    DEFINE_SETTINGFACT(domain510)

    DEFINE_SETTINGFACT(domain61)
    DEFINE_SETTINGFACT(domain62)
    DEFINE_SETTINGFACT(domain63)
    DEFINE_SETTINGFACT(domain64)
    DEFINE_SETTINGFACT(domain65)
    DEFINE_SETTINGFACT(domain66)
    DEFINE_SETTINGFACT(domain67)
    DEFINE_SETTINGFACT(domain68)
    DEFINE_SETTINGFACT(domain69)
    DEFINE_SETTINGFACT(domain610)

    DEFINE_SETTINGFACT(domain71)
    DEFINE_SETTINGFACT(domain72)
    DEFINE_SETTINGFACT(domain73)
    DEFINE_SETTINGFACT(domain74)
    DEFINE_SETTINGFACT(domain75)
    DEFINE_SETTINGFACT(domain76)
    DEFINE_SETTINGFACT(domain77)
    DEFINE_SETTINGFACT(domain78)
    DEFINE_SETTINGFACT(domain79)
    DEFINE_SETTINGFACT(domain710)

    DEFINE_SETTINGFACT(domain81)
    DEFINE_SETTINGFACT(domain82)
    DEFINE_SETTINGFACT(domain83)
    DEFINE_SETTINGFACT(domain84)
    DEFINE_SETTINGFACT(domain85)
    DEFINE_SETTINGFACT(domain86)
    DEFINE_SETTINGFACT(domain87)
    DEFINE_SETTINGFACT(domain88)
    DEFINE_SETTINGFACT(domain89)
    DEFINE_SETTINGFACT(domain810)

    DEFINE_SETTINGFACT(domain91)
    DEFINE_SETTINGFACT(domain92)
    DEFINE_SETTINGFACT(domain93)
    DEFINE_SETTINGFACT(domain94)
    DEFINE_SETTINGFACT(domain95)
    DEFINE_SETTINGFACT(domain96)
    DEFINE_SETTINGFACT(domain97)
    DEFINE_SETTINGFACT(domain98)
    DEFINE_SETTINGFACT(domain99)
    DEFINE_SETTINGFACT(domain910)

    DEFINE_SETTINGFACT(domain101)
    DEFINE_SETTINGFACT(domain102)
    DEFINE_SETTINGFACT(domain103)
    DEFINE_SETTINGFACT(domain104)
    DEFINE_SETTINGFACT(domain105)
    DEFINE_SETTINGFACT(domain106)
    DEFINE_SETTINGFACT(domain107)
    DEFINE_SETTINGFACT(domain108)
    DEFINE_SETTINGFACT(domain109)
    DEFINE_SETTINGFACT(domain1010)

    DEFINE_SETTINGFACT(domain111)
    DEFINE_SETTINGFACT(domain112)
    DEFINE_SETTINGFACT(domain113)
    DEFINE_SETTINGFACT(domain114)
    DEFINE_SETTINGFACT(domain115)
    DEFINE_SETTINGFACT(domain116)
    DEFINE_SETTINGFACT(domain117)
    DEFINE_SETTINGFACT(domain118)
    DEFINE_SETTINGFACT(domain119)
    DEFINE_SETTINGFACT(domain1110)

    // Although this is a global setting it only affects ArduPilot vehicle since PX4 automatically starts the stream from the vehicle side
    DEFINE_SETTINGFACT(apmStartMavlinkStreams)

    Q_PROPERTY(QString missionSavePath      READ missionSavePath    NOTIFY savePathsChanged)
    Q_PROPERTY(QString parameterSavePath    READ parameterSavePath  NOTIFY savePathsChanged)
    Q_PROPERTY(QString telemetrySavePath    READ telemetrySavePath  NOTIFY savePathsChanged)
    Q_PROPERTY(QString logSavePath          READ logSavePath        NOTIFY savePathsChanged)
    Q_PROPERTY(QString videoSavePath        READ videoSavePath      NOTIFY savePathsChanged)
    Q_PROPERTY(QString crashSavePath        READ crashSavePath      NOTIFY savePathsChanged)

    Q_PROPERTY(QString planFileExtension        MEMBER planFileExtension        CONSTANT)
    Q_PROPERTY(QString missionFileExtension     MEMBER missionFileExtension     CONSTANT)
    Q_PROPERTY(QString waypointsFileExtension   MEMBER waypointsFileExtension   CONSTANT)
    Q_PROPERTY(QString parameterFileExtension   MEMBER parameterFileExtension   CONSTANT)
    Q_PROPERTY(QString telemetryFileExtension   MEMBER telemetryFileExtension   CONSTANT)
    Q_PROPERTY(QString kmlFileExtension         MEMBER kmlFileExtension         CONSTANT)
    Q_PROPERTY(QString shpFileExtension         MEMBER shpFileExtension         CONSTANT)
    Q_PROPERTY(QString logFileExtension         MEMBER logFileExtension         CONSTANT)

    QString missionSavePath     ();
    QString parameterSavePath   ();
    QString telemetrySavePath   ();
    QString logSavePath         ();
    QString videoSavePath       ();
    QString crashSavePath       ();

    static MAV_AUTOPILOT    offlineEditingFirmwareTypeFromFirmwareType  (MAV_AUTOPILOT firmwareType);
    static MAV_TYPE         offlineEditingVehicleTypeFromVehicleType    (MAV_TYPE vehicleType);

    // Application wide file extensions
    static const char* parameterFileExtension;
    static const char* planFileExtension;
    static const char* missionFileExtension;
    static const char* waypointsFileExtension;
    static const char* fenceFileExtension;
    static const char* rallyPointFileExtension;
    static const char* telemetryFileExtension;
    static const char* kmlFileExtension;
    static const char* shpFileExtension;
    static const char* logFileExtension;

    // Child directories of savePath for specific file types
    static const char* parameterDirectory;
    static const char* telemetryDirectory;
    static const char* missionDirectory;
    static const char* logDirectory;
    static const char* videoDirectory;
    static const char* crashDirectory;

signals:
    void savePathsChanged();

private slots:
    void _indoorPaletteChanged();
    void _checkSavePathDirectories();
    void _languageChanged();

private:
    QTranslator _QGCTranslator;

};
