# pi-oneer

A free and opensource car in-dash stereo, made for SBCs like Raspberry Pis, Orange Pis and others.

![](https://i.imgur.com/Hp1oUfm.png)

Current features:

- Music indexing by ID3 tags

- Phone mirroring with VNC

- Music playback

Features in progress:

- Wi-fi hotspot

- Integrated maps (OpenStreetMap)



## Building

### Debian/Ubuntu

Tested under Debian 12 with Xorg.

```bash

sudo apt update

sudo apt install cmake g++ libqt6qml6 qt6-base-dev qt6-base-dev-tools qt6-declarative-dev pkg-config libid3-* libvncserver-dev libxcb-xinerama0 qml6-module-qtquick-controls qml6-module-qtquick-layouts qml6-module-qtquick-window qml6-module-qtqml-workerscript libqt6svg6 qml6-module-qtquick-templates qt6-multimedia-dev

cd Pi-oneer

cmake -S . -B build

make -j

```
