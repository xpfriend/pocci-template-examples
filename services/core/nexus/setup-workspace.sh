if [ `grep "^java:$" ${CONFIG_DIR}/workspaces.yml | wc -l` -eq 0 ]; then
    return
fi

if [ `docker ps | grep poccin_java_1 | wc -l` -eq 0 ]; then
    ${BIN_DIR}/open-workspace
fi

docker cp ./settings.xml poccin_java_1:/tmp/user_home/.m2/settings.xml
