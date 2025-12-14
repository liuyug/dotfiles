#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse

import logging
from logging.handlers import RotatingFileHandler


logger = logging.getLogger(__name__)


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

        if args.verbose > 1:
            level = logging.INFO - args.verbose * 10
            logging.basicConfig(
                level=level,
                format="[%(asctime)s %(filename)s->%(funcName)s():%(lineno)s]%(levelname)s: %(message)s",
            )
        else:
            # handlers = [
            #     RotatingFileHandler(
            #         filename='app.log',
            #         mode='w',
            #         maxBytes=512000,
            #         backupCount=4
            #     )
            # ]
            logging.basicConfig(
                # handlers=handlers,
                level=logging.INFO,
                format='%(levelname)s:%(message)s',
            )

        if args.hello:
            print('hello')
        else:
            parser.print_help()


if __name__ == '__main__':
    App().run()
