if (-not (Test-Path -Path .\.bin -PathType Container)) {
  New-Item -Path .\.bin -ItemType Directory
}
Compress-Archive -Path .\avr-wrt.FCStd\* -DestinationPath .\.bin\avr-wrt.FCStd -CompressionLevel NoCompression
