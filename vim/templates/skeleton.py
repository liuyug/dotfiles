#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse

import logging
# from logging.handlers import RotatingFileHandler

logger = logging.getLogger(__name__)


class ColorLogFormatter(logging.Formatter):
    """Logging colored formatter, adapted from https://stackoverflow.com/a/56944256/3638629"""
    # https://zh.wikipedia.org/wiki/ANSI%E8%BD%AC%E4%B9%89%E5%BA%8F%E5%88%97
    green = '\x1b[38;5;10m'
    grey = '\x1b[38;5;7m'
    blue = '\x1b[38;5;39m'
    yellow = '\x1b[38;5;226m'
    red = '\x1b[38;5;196m'
    bold_red = '\x1b[1;38;5;9m'
    reset = '\x1b[0m'

    def __init__(self, fmt):
        super().__init__()
        # only for old cmd window
        # colorama.just_fix_windows_console()

        self.fmt = fmt
        self.FORMATS = {
            logging.DEBUG: self.green + self.fmt + self.reset,
            logging.INFO: self.grey + self.fmt + self.reset,
            logging.WARNING: self.yellow + self.fmt + self.reset,
            logging.ERROR: self.red + self.fmt + self.reset,
            logging.CRITICAL: self.bold_red + self.fmt + self.reset
        }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


class App(object):
    name = 'Hello'
    description = ''
    version = '1.0'
    url = ''
    author_email = 'author@gmail.com'
    license = ''

    def run(self):
        about = f'{App.name} v{App.version} {App.description}'
        parser = argparse.ArgumentParser(description=App.description)
        parser.add_argument('--version', action='version', version=about,
                            help='show version')
        parser.add_argument('-v', '--verbose', action='count',
                            default=0, help='verbose output')

        parser.add_argument('--hello', action='store_true', help='hello')

        args = parser.parse_args()

        handlers = []
        if args.verbose > 1:
            level = logging.INFO - args.verbose * 10
            fmt = "[%(asctime)s %(filename)s->%(funcName)s():%(lineno)s]%(levelname)s: %(message)s"
        else:
            # log_handler = RotatingFileHandler(
            #     filename='app.log',
            #     mode='w',
            #     maxBytes=512000,
            #     backupCount=4
            # )
            # handlers.append(log_handler)
            level = logging.INFO
            fmt = '%(levelname)s:%(message)s'

        color_handler = logging.StreamHandler()
        color_handler.setFormatter(ColorLogFormatter(fmt))
        handlers.append(color_handler)

        logging.basicConfig(
            handlers=handlers,
            level=level,
        )

        if args.hello:
            print('hello')
            logger.debug('this is a DEBUG message')
            logger.info('this is an INFO message')
            logger.warning('this is a WARNING message')
            logger.error('this is an ERROR message')
            logger.critical('this is a CRITICAL message')
        else:
            parser.print_help()


if __name__ == '__main__':
    App().run()
