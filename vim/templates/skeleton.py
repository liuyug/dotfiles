#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse


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

        parser.add_argument('--hello', action='store_true', help='hello')

        args = parser.parse_args()
        if args.hello:
            print('hello')
        else:
            parser.print_help()


if __name__ == '__main__':
    App().run()
