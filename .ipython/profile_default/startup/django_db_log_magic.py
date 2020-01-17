from IPython.core.magic import register_line_magic

handler = None

@register_line_magic
def djlog(line):
    import logging

    django_db_logger = logging.getLogger('django.db')
    if not line or line == 'on':
        global handler
        if handler is None:
            handler = logging.StreamHandler()
        django_db_logger.addHandler(handler)
        django_db_logger.setLevel(logging.DEBUG)
    elif line == 'off':
        django_db_logger.setLevel(logging.NOTSET)
        django_db_logger.removeHandler(handler)
    else:
        raise AttributeError(f"Invalid choice: {line}")

