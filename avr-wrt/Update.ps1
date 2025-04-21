if (Test-Path -Path .\avr-wrt.FCStd -PathType Container) {
  Remove-Item -Path .\avr-wrt.FCStd -Recurse -Force
}
New-Item -Path .\avr-wrt.FCStd -ItemType Directory
Expand-Archive -Path .\.bin\avr-wrt.FCStd -DestinationPath .\avr-wrt.FCStd\
