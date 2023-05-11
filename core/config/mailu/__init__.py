""" Mailu config app
"""

import flask
import flask_bootstrap

#from mailu import utils, debug, models, manage, configuration
from mailu import configuration
from gunicorn import glogging
import logging

import hmac

class NoPingFilter(logging.Filter):
    def filter(self, record):
        if not (record.args['{host}i'] == 'localhost' and record.args['r'] == 'GET /ping HTTP/1.1'):
            return True

class Logger(glogging.Logger):
    def setup(self, cfg):
        super().setup(cfg)

        # Add filters to Gunicorn logger
        logger = logging.getLogger("gunicorn.access")
        logger.addFilter(NoPingFilter())

def create_app_from_config(config):
    """ Create a new application based on the given configuration
    """
    app = flask.Flask(__name__, static_folder='static', static_url_path='/static')

   # Bootstrap is used for error display and flash messages
    app.bootstrap = flask_bootstrap.Bootstrap(app)

    # Initialize application extensions
    config.init_app(app)

    def ping():
        return ''
    app.route('/ping')(ping)

    # Import views
    from mailu import internal
    app.register_blueprint(internal.internal, url_prefix='/internal')
    return app


def create_app():
    """ Create a new application based on the config module
    """
    config = configuration.ConfigManager()
    return create_app_from_config(config)

