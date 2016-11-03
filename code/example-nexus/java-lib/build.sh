#!/bin/bash
set -eu

mvn -B clean deploy --settings deploy-settings.xml
