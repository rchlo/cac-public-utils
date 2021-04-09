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
        echo ""
        echo "Configurando o .npmrc do usuário $HOME/.npmrc com credenciais"
        echo ""
        echo "Será necessário informar um token de acesso no az artifacts"
        echo "Veja como gerar em: https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page"
        echo "Obs: utilize a opção CUSTOM nas permissões do PAT TOKEN e utilize somente a permissão: READ do PACKAGING "
        echo ""
        read -p "Digite o PAT token gerado para seu usuário: "  PAT

        USER_NPM_RC="$HOME/.npmrc"
        PAT_B64=$(echo -n "$PAT" | base64 -w 0)
        echo "; begin auth token" > $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/:username=$SELECTED_ORG" >> $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/:_password=$PAT_B64"  >> $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/registry/:email=npm requires email to be set but doesn't use the value" >> $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/:username=$SELECTED_ORG"  >> $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/:_password=$PAT_B64"  >> $USER_NPM_RC
        echo "//pkgs.dev.azure.com/$SELECTED_ORG/_packaging/$SELECTED_ORG/npm/:email=npm requires email to be set but doesn't use the value"  >> $USER_NPM_RC
        echo "; end auth token"  >> $USER_NPM_RC
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
