#!/bin/bash

PS3='Selecione em qual organização: '
options=("DEVOPS-RCHLO" "DEVOPS-MIDWAY" "Quit")
SELECTED_ORG=""

function configureProjectNPMRC() {
    echo ""
    echo "Configurando o .npmrc do projeto com o feed da org selecionada"
    echo "registry=https://pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/" > .npmrc
    echo "always-auth=true" >> .npmrc
}

function configureUserNPMRC() {
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
