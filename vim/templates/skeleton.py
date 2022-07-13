#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse
import logging

logger = logging.getLogger(__name__)


class App():
    name = 'Hello'
    description = 'Hello'
    version = '1.0'
    url = ''
    author_email = 'author@gmail.com'
    license = 'MIT'

    @classmethod
    def run(cls):
        about = f'{App.name} v{App.version} {App.description}'
        parser = argparse.ArgumentParser(description=App.description)
        parser.add_argument('--version', action='version', version=about,
                            help='show version')
        parser.add_argument('-v', '--verbose', action='count',
                            default=0, help='verbose output')

        parser.add_argument('--hello', help='hello')

        args = parser.parse_args()
        level = logging.INFO - args.verbose * 10
        if level == logging.DEBUG:
            logging.basicConfig(
                level=level,
                format='%(levelname)s:%(name)s:%(message)s',
            )
        else:
            logging.basicConfig(
                level=level,
                format='%(levelname)s:%(message)s',
            )

        if args.hello:
            print('hello %s' % args.hello)
        else:
            parser.print_help()


if __name__ == '__main__':
    App.run()
