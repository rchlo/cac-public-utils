#! /usr/bin/pwsh


Write-Output "Selecione qual sua organização:"
Write-Output "1 - DEVOPS-RCHLO"
Write-Output "2 - DEVOPS-MIDWAY"
$a = Read-Host -Prompt "resposta: "

switch ($a) {
    1 { $org = "DEVOPS-RCHLO"; break }
    2 { $org = "DEVOPS-MIDWAY"; break }
    Default { "Tente outra vez" ; exit }
}
Write-Output "registry=https://pkgs.dev.azure.com/$org/_packaging/$org/npm/registry/" > .npmrc
Write-Output "always-auth=true" >> .npmrc

npm install -g vsts-npm-auth --registry https://registry.npmjs.com --always-auth false

vsts-npm-auth -config .npmrc
