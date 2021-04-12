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


npm install -g azure-devops-npm-auth
azure-devops-npm-auth --client_id='212f1e16-b6cc-432f-b4d6-14a5963428b9' --tenant_id='b8329613-0680-4673-a03f-9a18a0b0e93b'

