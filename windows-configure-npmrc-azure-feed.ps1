#! /usr/bin/pwsh


Write-Output "Selecione qual sua organizacao:"
Write-Output "1 - DEVOPS-RCHLO"
Write-Output "2 - DEVOPS-MIDWAY"
$a = Read-Host -Prompt "resposta: "

switch ($a) {
    1 { $org = "DEVOPS-RCHLO"; break }
    2 { $org = "DEVOPS-MIDWAY"; break }
    Default { "Tente outra vez" ; exit }
}

Remove-Item .npmrc -Force -Recurse -ErrorAction Ignore
Remove-Item $home/.npmrc -Force -Recurse -ErrorAction Ignore


Write-Output ""
Write-Output "Configurando o .npmrc do projeto com o feed da org selecionada"
Write-Output "registry=https://registry.npmjs.org" | Set-Content .npmrc
Write-Output "@midway:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" | Add-Content .npmrc
Write-Output "@riachuelo:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" | Add-Content .npmrc
Write-Output "@pub-libs:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" | Add-Content .npmrc
Write-Output "always-auth=true" | Add-Content .npmrc
Write-Output ""
Write-Output "# VEJA INFORMAÇÕES SOBRE O NPMRC AQUI: https://docs.npmjs.com/cli/v7/configuring-npm/npmrc"
Write-Output "# Leia e entenda a utilidade do npmrc e os diferentes locais que ele pode estar"
Write-Output "# o .npmrc do projeto ficou configurado da seguinte forma:"
Write-Output ""
Write-Output ""
type result.txt .npmrc
Write-Output ""
Write-Output ""


Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

npm install -s -g vsts-npm-auth --registry https://registry.npmjs.com --always-auth false

vsts-npm-auth -config .npmrc
