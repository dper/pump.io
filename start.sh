#!/usr/local/bin/bash
cd /home/pump/pump.io
forever start bin/pump -c pump.io.json
