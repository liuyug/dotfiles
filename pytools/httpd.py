#!/usr/bin/env python3
# -*- encoding:utf-8 -*-

import argparse
import socket
from http.server import HTTPServer, SimpleHTTPRequestHandler
from socketserver import ThreadingMixIn
import threading


def get_network_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    s.connect(('<broadcast>', 0))
    return s.getsockname()[0]


class Handler(SimpleHTTPRequestHandler):
    pass


class ThreadingSimpleServer(ThreadingMixIn, HTTPServer):
    pass


def run():
    parser = argparse.ArgumentParser(description='Simple HTTP(s) Server with threading')
    parser.add_argument('--cert', help='HTTPs cert file. To generate new cert/key: "openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 3650"')
    parser.add_argument('--key', help='HTTPs key file. To generate new cert/key: see above')
    parser.add_argument('listen', nargs='?', default='127.0.0.1:8000',
                        help='Listen IPAddress and Port. default: 127.0.0.1:8000')
    args = parser.parse_args()

    if args.listen:
        ip, _, port = args.listen.partition(':')
        port = int(port) if port else 8000
    else:
        ip = '127.0.0.1'
        port = 8000

    server = ThreadingSimpleServer((ip, port), Handler)
    if args.cert and args.key:
        import ssl
        server.socket = ssl.wrap_socket(
            server.socket,
            keyfile=args.key, certfile=args.cert,
            server_side=True)
    try:
        print('-- %s --' % parser.description)
        if ip == '0.0.0.0':
            sa = (get_network_ip(), port)
        else:
            sa = server.socket.getsockname()
        print('-- Listen on %s:%s --' % sa)
        server.serve_forever()
    except KeyboardInterrupt:
        print('\n-- Finished --')


if __name__ == '__main__':
    run()
