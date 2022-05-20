import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore


Item {
  //height and width, when widget is placed in plasma panel
  property string full: getString()


  function formatText(n) {
    return "" + n + "%"
  }

  function parseIP(ip) {
    var r = /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/;
    var t = ip.match(r);
    if (t != null) {
      return t[0]
    }
    return ""
  }

  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }

  // This gets the public ip address of the machine
  // If it is not connected to the internet (or the request fails) it returns an empty string
  function getPub() {
    var data = "{\n    \"Token\": \"" + getRandomInt(10000).toString() + "\n}";
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "http://v4.ident.me/", false);
    xhr.send(data)
    if (xhr.status == 200) {
      return parseIP(xhr.responseText)
    }
    return ""

  }

  // This gets the private ip address of the machine
  // If ip or ifconfig is not installed it will fail with an empty string
  function getPriv() {
    var req = new XMLHttpRequest()
    var path = "/proc/net/fib_trie"
    req.open("GET", path, false)
    req.send(null)
    if (!req.responseText) {
      return ""
    }
    var split = req.responseText.split("\n")
    for (var i = 0; i < split.length; i++) {
      var line = split[i]
      if (line.includes("/32")) {
        var ip = parseIP(split[i-1])
        var seg = ip.split(".")
        var start = seg[0].toString()
        if (! ["0", "127", "172", "255"].includes(start)) {
          return ip.toString()
        }
      }
    }
  }

  function getString() {
    var pub = getPub()
    var priv = getPriv()
    var pubcheck = pub && plasmoid.configuration.publicIP
    var privcheck = priv && plasmoid.configuration.privateIP
    var pubsymb = "🖧"
    var privsymb = "🔒"
    if (pubcheck && privcheck) {
      return(pubsymb + "-" + pub + " " + privsymb + "-" + priv)
    } else if (pubcheck) {
      return(pub)
    } else if (privcheck) {
      return(priv)
    } else {
      return("No IP")
    }
  }


  id: main
  anchors.fill: parent

  Layout.preferredWidth: 8
  Layout.preferredHeight: 2
  Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation


  Plasmoid.fullRepresentation: Item {
    Layout.minimumWidth: label.implicitWidth
    Layout.minimumHeight: label.implicitHeight
    Layout.preferredWidth: 64 * PlasmaCore.Units.devicePixelRatio
    Layout.preferredHeight: 48 * PlasmaCore.Units.devicePixelRatio

    PlasmaComponents.Label {
      id: label

      anchors.fill: parent

      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter

      text: getString()

      font.pixelSize: plasmoid.configuration.fontSize
      minimumPointSize: theme.smallestFont.pointSize
      fontSizeMode: Text.Fit
      font.bold: plasmoid.configuration.makeFontBold

    }


  }
  Timer {
    /* interval: plasmoid.configuration.updateInterval * 60 */
    interval: plasmoid.configuration.updateInterval * 60000
    running: true
    repeat: true
    onTriggered: {
      main.full = getString()
    }
  }
}
