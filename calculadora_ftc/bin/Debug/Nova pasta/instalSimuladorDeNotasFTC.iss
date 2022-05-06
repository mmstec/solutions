; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=CalculadoraFTC
AppVersion=1.5
DefaultDirName={pf}\MMSTEC\SimuladorDeNotasFTC
DefaultGroupName=\MMSTEC\SimuladorDeNotasFTC
UninstallDisplayIcon={app}\mmstec\SimuladorDeNotasFTC.exe
Compression=lzma2
SolidCompression=yes
;OutputDir=userdocs:Inno Setup Examples Output
OutputDir=C:\MMSTEC\INSTALADORES\SimuladorDeNotasFTC

[Files]
Source: "SimuladorDeNotasFTC.exe";     DestDir: "{app}"
Source: "mmstec.ico";             DestDir: "{app}"
Source: "001.wav";                DestDir: "{app}"
Source: "002.wav";                DestDir: "{app}"
Source: "003.wav";                DestDir: "{app}"
Source: "COMUNICADO CRITÉRIOS DE AVALIAÇÃO 2014.PDF"; DestDir: "{app}"

[Icons]
Name: {userdesktop}\SimuladorDeNotasFTC; Filename: {app}\SimuladorDeNotasFTC.exe;

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
