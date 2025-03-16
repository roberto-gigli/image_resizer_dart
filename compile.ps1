New-Item -Type Directory -Force -Path dist

if ($IsWindows) {
    dart compile exe bin\main.dart -o dist\image_resizer.exe
}

if ($IsMacOS -or $IsLinux) {
    dart compile exe bin\main.dart -o dist\image_resizer
}

