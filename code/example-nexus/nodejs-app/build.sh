#!/bin/bash
set -e

npm --loglevel info install
npm test
