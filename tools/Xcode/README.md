# Xcode Script Tools

## AppInfo Icon Maker

Shell Script tool of Xcode.

Make App Dev-Info more clearer and straight.
Info: 

- __Git-Info__ (e.g. ver-hash,branch)
- Xcode __Project-Info__ (e.g. short-version,build-number)
 
Add text of above info to the App-Icon image as a watermark.

![](doc/image/icon_eg2.png)


### Featrue 

- [x] Add infomation(git,project..) to App-Icon image.
- [x] Make a new 'AppIcon-Dev.appiconset' directory. You can select.

### Requirement

_test passed_

- MacOSX 10.x+ 
- Xcode 9+
- [ImageMagick](http://www.imagemagick.org/)

### Dependent On

#### Install

If you not install `brew`, flow step below to install(or ignore):

__[Homebrew](https://brew.sh/)__

```shell 
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

---

__[ImageMagick](http://www.imagemagick.org/)__ 

```shell
brew install imagemagick 
```

### INSTALL (Automatic)

Copy `install` script file to your project __folder__ as same as `.xcodeproj` directory, and run script:

```shell
./install
```

If nothing goes wrong, you are ready to go.
try <kbd>command</kbd> + <kbd>B</kbd> build project in Xcode.

_NOTE:Markup app icon only when CONFIGURATION=Debug_

#### `install` command options:

- __To unconfigure your project.__

```shell 
./install . noclean
./appicon_mark.rb uninstall --project <PATH_TO_YOUR_PROJECT>/<PROJECT_NAME>.xcodeproj
```

- __To remove all cache files.__

```
./install clean
```

### INSTALL (Manual)

You can ignore the following steps, if already do step `INSTALL (Automatic)` above.

#### 0x0 Import to project (Recommend)

Add tool to your project

__0x00:__

Add __2 files__ to the project(with copy).

- icon_mark
- lib/dev_kit.sh

BE-SURE: `icon_mark`, `lib` directory, in the same level.

![](doc/image/icon_eg6.png)

__0x01:__

`Xcode Project` -> `Target` -> `Build Phases` -> `Add 'Run Script'` -> `Edit to run script file`

Edit `Run Script` content:

```shell
"<Path-To-Script>/icon_mark"
```

![](doc/image/icon_eg8.png)

In this demo project use : `"${PROJECT_DIR}/${PROJECT_NAME}/Script/icon_mark`

__0x02:__

If `Build Phases` -> `Copy Bundle Resources` has the script files(`icon_mark`,`lib/dev_kit.sh`), and remove them.

![](doc/image/icon_eg7.png)


---

#### 0x1 Run And Setup.

1. First `Build` your project; if success, `AppIcon-Dev` was generated in the `.xcassets` folder.
2.  Set project -> target -> General -> App Icons and Launch Images -> App Icons Source to `AppIcon-Dev` 
3. `Run` again. the AppIcon will be setup.


![](doc/image/icon_eg4.png)
![](doc/image/icon_eg5.png)

__!Important__ 

- Make sure your project has the `.appiconset` folder which has a `size:1024x1024` of App icon image in it.
- The marked app icon only created in `Debug` CONFIGURATION.
- Only support One `.xcassets` Directory (Random selected) of project.


### Reference

- [iconVersion](https://github.com/krzysztofzablocki/IconOverlaying/blob/master/Scripts/iconVersioning.sh)

### LICENSE

__MIT__


## Related tools

- [App Icon Fitter](https://github.com/poplax/app-icon-fitter)
- [AppInfo Icon Marker](https://github.com/poplax/app-icon-fitter/blob/master/tools/Xcode)