#!/bin/bash
set -e

export NPM_REGISTRY=${NPM_PRIVATE_REGISTRY_URL}

npm --loglevel info install
npm test

npm-cli-login
npm publish --registry ${NPM_PRIVATE_REGISTRY_URL}/
