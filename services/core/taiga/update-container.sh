TAIGA_BACK_CONTAINER=${POCCI_SERVICE_PREFIX}_taigaback_1
TAIGA_FRONT_CONTAINER=${POCCI_SERVICE_PREFIX}_taiga_1

cat << EOF >/tmp/taiga-settings
INSTALLED_APPS += ["taiga_contrib_ldap_auth"]

LDAP_SERVER = "${LDAP_URL}"
LDAP_PORT = 389
LDAP_BIND_DN = "${LDAP_BIND_DN}"
LDAP_BIND_PASSWORD = "${LDAP_BIND_PASSWORD}"
LDAP_SEARCH_BASE = "${LDAP_BASE_DN}"
LDAP_SEARCH_PROPERTY = "${LDAP_ATTR_LOGIN}"
LDAP_SEARCH_SUFFIX = None
LDAP_EMAIL_PROPERTY = "${LDAP_ATTR_MAIL}"
LDAP_FULL_NAME_PROPERTY = "displayName"
EOF

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

pip install git+https://github.com/ensky/taiga-contrib-ldap-auth.git
cat /tmp/taiga-settings >> ./settings/local.py
EOF


docker cp /tmp/taiga-settings ${TAIGA_BACK_CONTAINER}:/tmp
docker cp /tmp/initialize ${TAIGA_BACK_CONTAINER}:/tmp
rm /tmp/taiga-settings
rm /tmp/initialize

${LIB_DIR}/docker-exec ${TAIGA_BACK_CONTAINER} bash /tmp/initialize
