#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse
import logging

logger = logging.getLogger(__name__)


def main():
    name = 'app'
    version = '1.0.0'
    description = 'Application Description'
    about = f'{name} v{version} {description}'
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--version', action='version', version=about,
                        help='show version')
    parser.add_argument('-v', '--verbose', action='count',
                        default=0, help='verbose output')

    group = parser.add_argument_group('group')
    group.add_argument('--hello', action='store_true', help='hello')

    args = parser.parse_args()
    # log to stdout in cli mode
    level = logging.INFO - args.verbose * 10
    logging.basicConfig(
        level=level,
        format='%(message)s',
    )

    if args.hello:
        logger.info(f'Hello {name}')
    else:
        parser.print_help()


if __name__ == '__main__':
    main()
