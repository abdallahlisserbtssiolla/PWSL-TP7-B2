$SharedFolder = "\\DC-CLEANERGYO\Applications$"

$LocalFolder = "C:\TEMP"

$ExeName = "vlc-3.0.20.exe"

$ExeArgument = "/S"

$ExeVersion = "3.0.20"

$ExeInstallPath = "C:\Program Files (x86)\VLC\VLC.exe"

$InstalledVersion = (Get-ItemProperty -Path "C:\Program Files (x86)\VLC\VLC.exe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

if(($InstalledVersion -eq $null) -or ($InstalledVersion -ne $null -and $InstalledVersion -ne $ExeVersion)){

   # Si $InstalledVersion n'est pas null et que la version est différente : c'est qu'il faut faire une mise à jour
   if($InstalledVersion -ne $null){ 
      Write-Output "Le logiciel va être mis à jour : $InstalledVersion -> $ExeVersion"
   }

   if(Test-Path "$SharedFolder\$ExeName"){

     New-Item -ItemType Directory -Path "$LocalFolder" -ErrorAction SilentlyContinue
     Copy-Item "$SharedFolder\$ExeName" "$LocalFolder" -Force

     if(Test-Path "$LocalFolder\$ExeName"){
        Start-Process -Wait -FilePath "$LocalFolder\$ExeName" -ArgumentList "$ExeArgument"
     }

     Remove-Item "$LocalFolder\$ExeName"

   }else{

     Write-Warning "L'exécutable ($ExeName) est introuvable sur le partage !"
   }
}else{
   Write-Output "Le logiciel est déjà installé dans la bonne version !"
}
