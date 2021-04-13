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


Write-Output "registry=https://pkgs.dev.azure.com/$org/_packaging/$org/npm/registry/" | Set-Content .npmrc
Write-Output "always-auth=true" | Add-Content .npmrc


Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

npm install -s -g vsts-npm-auth --registry https://registry.npmjs.com --always-auth false

vsts-npm-auth -config .npmrc
