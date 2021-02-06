# Retro Multi Manager



##### Table of contents

<!-- toc -->

- [About](#about)
- [Warning](#warning)
- [Limitations](#limitations)
- [Getting started](#getting-started)
  * [Installation](#installation)
- [Features](#features)
- [Roadmap](#roadmap)
- [Discord](#discord)
- [Licenses](#licenses)

<!-- tocstop -->

## About

RMM is an open-source light-weight program to manage your accounts on **Dofus Retro 1.33.6**.

Initially based on a simple 100 lines file, it has now more than a couple thousand of it, adding features like a **GUI**, an **account profile** system, a **customizable scenario system**, and many more... (see list of features below for an expanded list).

It is developed with the sweet [AutoHotKey](https://www.autohotkey.com/) scripting language.

## Warning

This software is **not a cheat** and **never will be**. Its only purpose is to play the game with multiple accounts easier than what is currently offered by the game itself. If you are looking for something that plays the game for you, you are not in the right place.

## Limitations

Because it uses predefined position to perform actions, RMM is currently only available for these resolutions :

- 1360x768
- 1366x768
- 1600x900
- 1920x1080
- 2560x1440
- 2560x1600
- 3840x2160

If you have another resolution, you will have to gather cursor position from Dofus menu, please do as follow :
1. Download our tool [GetPos.exe](https://github.com/DetroitApps/RetroMultiManager/tree/master/Tools/GetPos "Tool GetPos") and save it on your desktop.
2. Execute it.
3. Open your Dofus instance and maximise the window.
4. Place your mouse cursor on the exact middle of the login input, then press "Print Screen" key (keyboard).
5. Reapeat the same actions for every server's slot (after login page).
6. Press "Echap" to exit the application.
7. In "resources" folder, fill "ConnectPlayersOnServer.ini" and "LoginAccounts.ini" with gathered mouse position (see generated logs from GetPos.exe).
8. Contact us to add the resolution natively in RMM.

## Getting started

### Installation

#### I trust the developer and I'm lazy

- Go on the [release page](https://github.com/DetroitApps/RetroMultiManager/releases) and **download the last release**.
- Unzip the archive, preferably **<u>not</u>** in a Windows special folders (Program Files, App Data etc...)
- Start **RetroMultiManager.exe**

#### From sources

- Download and install [AutoHotKey](https://www.autohotkey.com/).
- Go on the [release page](https://github.com/DetroitApps/RetroMultiManager/releases) and **download the last sources release** or clone the repository.
- Unzip the archive, preferably **<u>not</u>** in a Windows special folders (Program Files, App Data etc...)
- Right-click on **app.ahk** and click on **Compile Script** or **Run Script**.

## Features

<img align="right" height="300" width="300" src="../assets/gui.png?raw=true" alt="Retro Multi Manager GUI"/>

- A powerful interface to manage your accounts
  - Multiple profiles
  - Independent from the main script, so it can be hidden to use RMM with hotkeys only
- Secure account
  - Username and password encrypted
  - Master password safelock
- Embedded scenario system
  - Automatize many actions in the game, included scenarios are :
    - Open Dofus instances (opens as many instances as you have accounts)
    - Autologin
    - Connect players on server
    - Toggle between your Dofus instances
    - Character initiative management
    - Change character's initiative during the game session
    - Move all characters at once
    - Close all Dofus instances
  - Develop scenarios with the API
    - Endless possibilities
- Multiple languages, for now:
  - French
  - English
- Update checker

## RoadMap

[Trello](https://trello.com/b/NcZHByWN/retro-multi-manager-dev)

If you have an account on Trello, you are allowed to comment cards.

## Discord

If you have any question, feel free to join us on our [discord server](https://discord.gg/7esKrb77TP) !

## License

Copyright © 2019 Detroit Apps

The content of this repository is bound by the following license(s):

- The computer software Retro Multi Manager and its associated source code is licensed under the [GNU General Public License v3.0](https://github.com/DetroitApps/RetroMultiManager/blob/master/LICENSE) license.
- The license doesn't apply for Library files
  - [SB_SetProgress]( https://autohotkey.com/board/topic/34593-stdlib-sb-setprogress/ ) by derRaphael ([EUPL v1.0](https://spdx.org/licenses/EUPL-1.0.html))
  - [i18n-autohotkey](https://github.com/iammael/i18n-autohotkey) by [IAmMael](https://github.com/iammael/) ([MIT](https://github.com/iammael/i18n-autohotkey/blob/master/LICENSE))
-  Icon made by [monkik](https://www.flaticon.com/authors/monkik) from [www.flaticon.com](http://www.flaticon.com/) 

