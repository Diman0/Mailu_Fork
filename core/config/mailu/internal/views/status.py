from mailu.internal import internal

import flask
import datetime

@internal.route("/status")
def status():
    return 200