import QtQuick 2.6
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
  property alias cfg_updateInterval: updateInterval.value
  property alias cfg_publicIP: publicIP.checked
  property alias cfg_privateIP: privateIP.checked
  property alias cfg_makeFontBold: makeFontBold.checked
  property alias cfg_fontSize: fontSize.value

  ColumnLayout {
    RowLayout {
      Label {
        id: updateIntervalLabel
        text: i18n("Update interval")
      }
      SpinBox {
        id: updateInterval
        decimals: 1
        stepSize: 0.1
        minimumValue: 0.1
        suffix: i18nc("Abbreviation for minutes", "m")
      }
    }
    CheckBox {
      id: publicIP
      text: i18n("Public IP")
    }
    CheckBox {
      id: privateIP
      text: i18n("Private IP")
   }
    CheckBox {
      id: makeFontBold
      text: i18n("Bold Text")
    }
    RowLayout {
      Label {
        id: fontSizeLabel
        text: i18n("Font Size")
      }
      SpinBox {
        id: fontSize
        stepSize: 1
        minimumValue: 5
        suffix: i18nc("Abbreviation for point", "pt")
      }
    }

  }
}
