# AppIconFitter

AppIconFiter is a tool of create different size images for the App.

this version(0.1.0) only support 'iOS' App.

## Requirement

- MacOSX or Linux (Fedora, RedHat, SUSE...)
- [ImageMagick](http://www.imagemagick.org/)
- [pngcrash](https://pmt.sourceforge.io/pngcrush/)

## Install Depends

### Homebrew

```shell
brew install imagemagick pngcrash
```

### Yum

```shell
yum install -y ImageMagick pngcrash
```

## Featrue (AND TODO)

- [x] Create all size of Xcode project icon.(iOS) 
- [x] Resize one image.
- [x] Short text of icon set.
- [x] Compress png file.
- [ ] Create size of icon for Android.
- [ ] Compress jpeg file.

## Usage

See help.

```shell
icon_fits -h
```

Example:

Resize 120(`px`) of the icon(`gray_1024.png`), add subtitle : `DemoApp` as watermark, create one icon to the specific directory:

```shell
./icon_fits -s 120 -f gray_1024.png -o iconFitResize -t "DemoApp"
```

```shell
./icon_fits -c -s 120 -o iconFitResize -t "DemoApp" gray_1024.png
```

Create all size of the platform(default: iOS) support.

```shell
./icon_fits -k -f blue_1024.png -o iconFit
```

```shell
./icon_fits -co iconFitCompress blue_1024.png
```


## License

MIT.
