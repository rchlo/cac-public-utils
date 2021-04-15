#!/bin/bash

PS3='Selecione em qual organização: '
options=("DEVOPS-RCHLO" "DEVOPS-MIDWAY" "Quit")
SELECTED_ORG=""

function configureProjectNPMRC() {
    echo ""
    echo "Configurando o .npmrc do projeto com o feed da org selecionada"
    echo "registry=https://registry.npmjs.org" > .npmrc
    echo "@midway:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" >> .npmrc
    echo "@riachuelo:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" >> .npmrc
    echo "@pub-libs:registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" >> .npmrc
    echo "always-auth=true" >> .npmrc
    echo ""
    echo "# VEJA INFORMAÇÕES SOBRE O NPMRC AQUI: https://docs.npmjs.com/cli/v7/configuring-npm/npmrc"
    echo "# Leia e entenda a utilidade do npmrc e os diferentes locais que ele pode estar"
    echo "# o .npmrc do projeto ficou configurado da seguinte forma:"
    cat .npmrc
    echo ""
    echo ""
}

function configureUserNPMRC() {
          sudo npm install -s -g azure-devops-npm-auth --registry https://registry.npmjs.com --always-auth false
          azure-devops-npm-auth --client_id='212f1e16-b6cc-432f-b4d6-14a5963428b9' --tenant_id='b8329613-0680-4673-a03f-9a18a0b0e93b'
}

select opt in "${options[@]}"
do
    case $opt in
        "DEVOPS-RCHLO")
            SELECTED_ORG="DEVOPS-RCHLO"
            configureProjectNPMRC
            configureUserNPMRC
            break
            ;;
        "DEVOPS-MIDWAY")
            SELECTED_ORG="DEVOPS-MIDWAY"
            configureProjectNPMRC
            configureUserNPMRC
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
