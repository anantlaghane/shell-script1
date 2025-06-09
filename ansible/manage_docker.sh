#!/bin/bash

ACTION=$1
TARGET=$2
LOG_DIR="./logs"


ALL_CONTAINERS=("sonarqube" "notes-app-running" "mysql" "backend")


mkdir -p "$LOG_DIR"

if [[ "$TARGET" == "all" ]]; then
    CONTAINERS=("${ALL_CONTAINERS[@]}")
elif [[ "$TARGET" == "artifactory" ]]; then
    CONTAINERS=("postgres" "artifactory-jcr")
else
    CONTAINERS=("$TARGET")
fi


for CONTAINER in "${CONTAINERS[@]}"; do
    echo "==== Action: $ACTION | Container: $CONTAINER ===="

    LOG_FILE="${LOG_DIR}/${CONTAINER}_${ACTION}_$(date +%F_%H-%M-%S).log"

    case $ACTION in
        start)
            docker start $CONTAINER > "$LOG_FILE" 2>&1
            ;;
        stop)
            docker stop $CONTAINER > "$LOG_FILE" 2>&1
            ;;
        status)
            docker ps -a --filter "name=$CONTAINER" > "$LOG_FILE" 2>&1
            ;;
        restart)
            docker restart $CONTAINER > "$LOG_FILE" 2>$1
            ;;
        *)
            echo " Invalid action: $ACTION" | tee "$LOG_FILE"
            exit 1
            ;;
    esac

    echo "Log saved: $LOG_FILE"
done
