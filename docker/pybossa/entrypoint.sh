#!/bin/sh

INST=/opt/pybossa

# POSTGRES_URL="postgresql://username:password@host/database"
if [ -z "${POSTGRES_URL}" ]; then
    echo "One or more required variables are not set (POSTGRES_URL)"
    exit 1
fi

if [ ! -e "${INST}/alembic.ini" ]
then
    cp ${INST}/alembic.ini.template ${INST}/alembic.ini

    sed -i -e "s|postgresql://pybossa:tester@localhost/pybossa|${POSTGRES_URL}|" ${INST}/alembic.ini
fi

if [ ! -e "${INST}/settings_local.py" ]
then
    cp ${INST}/settings_local.py.tmpl ${INST}/settings_local.py

    sed -i -e "s|postgresql://pybossa:tester@localhost/pybossa|${POSTGRES_URL}|" \
        -e "s/('localhost', 26379)/('${REDIS_SENTINEL}', 26379)/" \
        -e "s/mymaster/${REDIS_MASTER}/" ${INST}/settings_local.py

fi

exec "$@"
