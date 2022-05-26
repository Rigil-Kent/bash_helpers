#!/bin/bash

function github_config {
    if [[ -z $GITHUB_REPO || -$GITHUB_REPO -eq "testing" ]]; then
        URL=""

        while [[ -z $URL ]]; do
            echo "Configuring github remote repository"
            echo -n "Enter the github url to this repo: "
            read URL
        done

        export GITHUB_REPO=$URL
        echo "export GITHUB_REPO=\"${URL}\"" >> $HOME/.bashrc
    fi

    echo $GITHUB_REPO
}


function gitlab_config {
    if [[ -z $GITLAB_REPO || -$GITLAB_REPO -eq "testing" ]]; then
        URL=""

        while [[ -z $URL ]]; do
            echo "Configuring gitlab remote repository"
            echo -n "Enter the gitlab url to this repo: "
            read URL
        done

        export GITLAB_REPO=$URL
        echo "export GITLAB_REPO=\"${URL}\"" >> $HOME/.bashrc
    fi

    echo $GITLAB_REPO
}


function config_multi_repo {
    if [[ -z $GITLAB_REPO || -z $GITHUB_REPO ]]; then
        echo "Configuring multi repo"
        github_config
        gitlab_config
    fi

    # Initialize git
    git init

    # switch to main branch
    git switch -c main

    # Define the one remote to rule them all
    git remote add all $GITHUB_REPO

    # Register the github push uri
    git remote set-url --add --push all $GITHUB_REPO

    # Register the gitlab push uri
    git remote set-url --add --push all $GITLAB_REPO

    # Fetch all updates
    git fetch --all
}


config_multi_repo