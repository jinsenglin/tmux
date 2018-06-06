#!/bin/bash

set -e

function tmux5() {
    tmux new-session -d
    tmux split-window -t 0 -h
    tmux split-window -t 1 -v
    tmux split-window -t 1 -v
    tmux split-window -t 1 -v
    tmux select-layout main-horizontal

    # license-server
    tmux send-keys -t 1 C-z 'sshpass -pcclin ssh cclin@192.168.240.30' Enter
    sleep 1
    tmux send-keys -t 1 C-z 'cd k8s-workspace' Enter

    # no-internet-jb
    tmux send-keys -t 2 C-z 'sshpass -pcclin ssh cclin@192.168.240.30' Enter
    sleep 1
    tmux send-keys -t 2 C-z 'ssh cclin@192.168.202.22' Enter
    sleep 1
    tmux send-keys -t 2 C-z 'cd k8s-workspace' Enter

    # hostx i.e. deploy-server
    tmux send-keys -t 0 C-z 'sshpass -pcclin ssh cclin@192.168.240.30' Enter
    sleep 1
    tmux send-keys -t 0 C-z 'ssh cclin@192.168.202.22' Enter
    sleep 1
    tmux send-keys -t 0 C-z 'ssh -o StrictHostKeyChecking=no centos@192.168.33.200' Enter

    # host1 i.e. k8s-master1
    tmux send-keys -t 3 C-z 'sshpass -pcclin ssh cclin@192.168.240.30' Enter
    sleep 1
    tmux send-keys -t 3 C-z 'ssh cclin@192.168.202.22' Enter
    sleep 1
    tmux send-keys -t 3 C-z 'ssh -o StrictHostKeyChecking=no centos@192.168.33.101' Enter

    # host4 i.e. k8s-worker1
    tmux send-keys -t 4 C-z 'sshpass -pcclin ssh cclin@192.168.240.30' Enter
    sleep 1
    tmux send-keys -t 4 C-z 'ssh cclin@192.168.202.22' Enter
    sleep 1
    tmux send-keys -t 4 C-z 'ssh -o StrictHostKeyChecking=no centos@192.168.33.104' Enter

    tmux select-pane -t 1
    tmux attach
}

tmux5
