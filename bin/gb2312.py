#!/usr/bin/env python
# -*- encoding:utf-8 -*-

import sys
import struct


def gb2312_set(errors=None):
    char_set = []
    sec_begin = 1
    sec_end = 94
    pos_begin = 1
    pos_end = 94
    for x in range(sec_begin, sec_end + 1):
        for y in range(pos_begin, pos_end + 1):
            code = struct.pack('2B', x + 0xa0, y + 0xa0)
            ch = code.decode('gbk', errors='ignore')
            if not ch and errors:
                ch = errors
            char_set.append(ch)
    return char_set


def txt(output=sys.stdout):
    err_ch = '　'.decode('utf-8')
    char_set = gb2312_set(errors=err_ch)
    nSec = 94
    nPos = 94
    output.write(' ' * 2)
    for x in range(0, nPos):
        output.write(' %02d' % (x + 1))
    output.write('\n')
    for x in range(0, nSec):
        output.write('%02d' % (x + 1))
        for y in range(0, nPos):
            output.write(' %s' % char_set[x * nSec + y].encode('utf-8'))
        output.write('\n')


def html(output=sys.stdout):
    char_set = gb2312_set()
    nSec = 94
    nPos = 94
    html = []
    html.append('<!DOCTYPE html>')
    html.append('<html>')
    html.append('<head>')
    html.append('<meta charset="UTF-8" />')
    html.append('<title>CODE TABLE of GB2312-80</title>')
    html.append('<style type="text/css">')
    html.append('table {border-collapse:collapse;border-spacing:0;}')
    html.append('td {border:1px solid green;padding:0.3em;text-align:center;}')
    html.append('hr {border:width:75%;}')
    html.append('</style>')
    html.append('</head>')
    html.append('<h1>CODE TABLE of GB2312-80</h1>')
    html.append('<p>Made by Yugang LIU</p>')
    html.append('<hr />')
    html.append('<ul>')
    html.append('<li>s: section</li>')
    html.append('<li>p: position</li>')
    html.append('</ul>')
    html.append('<p>code = (0xA0 + sec) << 8 + (0xA0 + pos)</p>')
    html.append('<body>')
    html.append('<table>')
    html.append('<tr>')
    html.append('<td>s\p</td>')
    for x in range(0, nPos):
        html.append('<td>%d</td>' % (x + 1))
    html.append('</tr>')
    for x in range(0, nSec):
        html.append('<tr>')
        html.append('<td>%d</td>' % (x + 1))
        for y in range(0, nPos):
            html.append('<td>%s</td>' % char_set[x * nSec + y].encode('utf-8'))
        html.append('</tr>')
    html.append('</table>')
    html.append('</body>')
    html.append('</html>')
    return output.write('\n'.join(html))


if __name__ == '__main__':
    # txt()
    html()
