#!/usr/bin/env python
# -*- encoding:utf-8 -*-

import sys
import binascii
import argparse


def ascii(output=sys.stdout):
    nondisp_ascii = {
        0: 'NUL (null)',
        1: 'SOH (start of heading)',
        2: 'STX (start of text)',
        3: 'ETX (end of text)',
        4: 'EOT (end of transmission)',
        5: 'ENQ (enquiry)',
        6: 'ACK (acknowledge)',
        7: 'BEL (bell)',
        8: 'BS  (backspace)',
        9: 'TAB (horizontal tab)',
        10: 'LF  (NL line feed, new line)',
        11: 'VT  (vertical tab)',
        12: 'FF  (NP form feed, new page)',
        13: 'CR  (carriage return)',
        14: 'SO  (shift out / X-on)',
        15: 'SI  (shift in / X-off)',
        16: 'DLE (data link escape)',
        17: 'DC1 (device control 1 / oft. XON)',
        18: 'DC2 (device control 2)',
        19: 'DC3 (device control 3 / oft. XOFF)',
        20: 'DC4 (device control 4)',
        21: 'NAK (negative acknowledge)',
        22: 'SYN (synchronous idle)',
        23: 'ETB (end of trans. block)',
        24: 'CAN (cancel)',
        25: 'EM  (end of medium)',
        26: 'SUB (substitute)',
        27: 'ESC (escape)',
        28: 'FS  (file separator)',
        29: 'GS  (group separator)',
        30: 'RS  (record separator)',
        31: 'US  (unit separator)',
        32: 'Space',
        127: 'DEL',
    }
    print(' | DEC  HEX   HTML Symbol')
    for code, desc in nondisp_ascii.items():
        print(' | %3d 0x%02x &#%03d; %s' % (code, code, code, desc))
    print('\n')
    char_begin = 32
    char_end = 128
    codes = range(char_begin, char_end)
    header = ' | DEC  HEX   HTML CH'
    ncol = 80 // len(header)
    nrow = len(codes) // ncol
    less = len(codes) % ncol
    for x in range(0, ncol):
        output.write(header)
    output.write(' |\n')
    for x in range(0, nrow):
        for y in range(0, ncol):
            code = codes[x + y * nrow]
            char_line = ' | %3d 0x%02x &#%03d; %02c' % (code, code, code, chr(code))
            output.write(char_line)
        output.write(' |\n')
    if less:
        for x in range(less, 0, -1):
            code = codes[-x]
            char_line = ' | %3d 0x%02x &#%03d; %02c' % (code, code, code, chr(code))
            output.write(char_line)
        output.write(' |\n')
    return


def ascii_to_code(chars):
    codes = binascii.b2a_hex(chars)
    print(codes)


def code_to_ascii(codes):
    chars = binascii.a2b_hex(codes)
    print(chars)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--code', dest='char', help='convert char to HEX code')
    parser.add_argument('--char', dest='code', help='convert HEX code to char')
    parser.add_argument('--ascii', action='store_true', help='print ascii')
    args = parser.parse_args()

    if args.char:
        ascii_to_code(args.char)
    elif args.code:
        code_to_ascii(args.code)
    else:
        ascii()

if __name__ == '__main__':
    main()
