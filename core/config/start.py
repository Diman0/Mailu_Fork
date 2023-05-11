#!/usr/bin/env python3

import os
import logging as log
from socrate import system

system.drop_privs_to('mailu')

system.set_env(['SECRET'])

cmdline = [
	"gunicorn",
	"--threads", f"{os.cpu_count()}",
	# If SUBNET6 is defined, gunicorn must listen on IPv6 as well as IPv4
	"-b", f"{'[::]' if os.environ.get('SUBNET6') else ''}:80",
    "--logger-class mailu.Logger",
    "--worker-tmp-dir /dev/shm",
	"--error-logfile", "-",
	"--preload"
]

# logging
if log.root.level <= log.INFO:
	cmdline.extend(["--access-logfile", "-"])

cmdline.append("'mailu:create_app()'")

os.system(" ".join(cmdline))
