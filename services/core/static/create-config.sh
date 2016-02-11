
if [ ! -d "${STATIC_DIR}" ]; then
    mkdir -p "${STATIC_DIR}"
fi

if [ ! -f "${STATIC_DIR}"/index.html ]; then
    echo '<html><body>Pocci</body></html>' >"${STATIC_DIR}"/index.html
fi
