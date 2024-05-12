$SharedFolder = "\\DC-CLEANERGYO\Applications$"

$LocalFolder = "C:\TEMP"

$ExeName = "supercopier_2.3.1.exe"

$ExeArgument = "/S"

$ExeVersion = "2.3.1"

$ExeInstallPath = "C:\Program Files (x86)\SuperCopier\SuperCopier.exe"

$InstalledVersion = (Get-ItemProperty -Path "C:\Program Files (x86)\SuperCopier\SuperCopier.exe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

if(($InstalledVersion -eq $null) -or ($InstalledVersion -ne $null -and $InstalledVersion -ne $ExeVersion)){

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
