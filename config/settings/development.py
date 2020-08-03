from .base import *  # noqa
from .base import env



# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# https://docs.djangoproject.com/en/dev/ref/settings/#secret-key
SECRET_KEY = env(
    "DJANGO_SECRET_KEY",
    default="XJ0Jddfm1yi4l7RgPR9YuarYTVDbfeY69Z8To2vkN9RYXXGBSxo63HL9pjxx08Od",
)
# https://docs.djangoproject.com/en/dev/ref/settings/#allowed-hosts
ALLOWED_HOSTS = env(
    "ALLOWED_HOSTS",
    # default=["localhost", "0.0.0.0", "127.0.0.1"]
    default=['*']
)

INSTALLED_APPS += [
    "debug_toolbar",
    "django_extensions",

]  # noqa F405


MIDDLEWARE = ["debug_toolbar.middleware.DebugToolbarMiddleware"] + MIDDLEWARE  # noqa F405

# https://django-debug-toolbar.readthedocs.io/en/latest/installation.html#internal-ips
# INTERNAL_IPS = ["10.145.205.165",]

# shutup and show yourself, no more need to set INTERNAL_IPS
DEBUG_TOOLBAR_CONFIG = {
    "SHOW_TOOLBAR_CALLBACK" : lambda request: True,
}
