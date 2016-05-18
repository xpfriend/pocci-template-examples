TAIGA_BACK_CONTAINER=${POCCI_SERVICE_PREFIX}_taigaback_1

cat << EOF >/tmp/initialize
echo "Waiting for Taiga..."
while ! nc -z 127.0.0.1 8000; do
  sleep 1
done

echo "Initialize Taiga..."
cd /usr/local/taiga/taiga-back/
python manage.py loaddata initial_user
python manage.py loaddata initial_project_templates
python manage.py loaddata initial_role
EOF

docker cp /tmp/initialize ${TAIGA_BACK_CONTAINER}:/tmp
rm /tmp/initialize

${LIB_DIR}/docker-exec ${TAIGA_BACK_CONTAINER} bash /tmp/initialize
