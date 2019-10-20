# Retro Multi Manager



##### Table of contents

<!-- toc -->

- [About](#about)
- [Limitations](#limitations)
- [Getting started](#getting-started)
  * [Installation](#installation)
- [Features](#features)

<!-- tocstop -->

## About

RMM is an open-source light-weight program to manage your accounts on **Dofus Retro**.

Initially based on a simple 100 lines file, it has now more than a thousand of it, adding features like a **GUI**, an **account profile** system, a **customizable scenario system**, OCR, and many more... (see list of features below for an expanded list).

It is developed with the sweet [AutoHotKey](https://www.autohotkey.com/) scripting language.

## Limitations

The software is currently only available for resolution 1920x1080 and 2560x1440. Other resolutions won't benefit from all the features.

## Getting started

### Installation

#### I trust the developer and I'm lazy

- Go on the [release page](https://github.com/DetroitApps/RetroMultiManager/releases) and **download the last release**.
- Install Retro Multi Manager with the provided installer.

#### From sources

- Download and install [AutoHotKey](https://www.autohotkey.com/).
- Go on the [release page](https://github.com/DetroitApps/RetroMultiManager/releases) and **download the last sources release**.
- Extract the archive anywhere on your computer.
- Right-click on **Retro Multi Manager.ahk** and click on **Compile Script** or **Run Script**.

## Features

- A powerful interface to manage your accounts
  - Multiple profiles
  - Independent from the main script, so it can be disabled to use RMM with shortcuts only
- Secure account
  - Password encrypted
  - Master password safelock
- Embedded scenario system
  - Automatize many actions in the game, included scenarios are :
    - Open Dofus instances (opens as many instances as you have accounts)
    - Autologin (fills account form with OCR or INI settings)
    - Connect to servers and characters
    - Toggle between your Dofus instances
    - Close all Dofus instances
  - Develop scenarios with the API (early alpha)
    - Endless possibilities
- Update checker
