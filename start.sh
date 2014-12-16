#!/usr/local/bin/bash
cd /home/pump/pump.io
forever start /home/pump/pump.io/bin/pump -c /home/pump/pump.io/pump.io.json
