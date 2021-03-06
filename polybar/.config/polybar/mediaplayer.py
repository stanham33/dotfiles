#!/usr/bin/python
import dbus


def main():
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify",
                                         "/org/mpris/MediaPlayer2")
    spotify_properties = dbus.Interface(spotify_bus,
                                        "org.freedesktop.DBus.Properties")
    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player",
                                      "Metadata")

    print("{} - {}".format(
        metadata["xesam:artist"][0],
        metadata["xesam:title"]))


if __name__ == "__main__":
    main()
