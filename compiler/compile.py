#!/usr/bin/python3

import re

ops = {
    "simals": "10000",
    "simahs": "10001",
    "simsls": "10010",
    "simshs": "10011",
    "slimals": "10100",
    "slimahs": "10101",
    "slimsls": "10110",
    "slimshs": "10111",
    "nop": "1100000000",
    "ah": "1100000001",
    "ahs": "1100000010",
    "bcw": "1100000011",
    "cgh": "1100000100",
    "clz": "1100000101",
    "max": "1100000110",
    "min": "1100000111",
    "msgn": "1100001000",
    "popcnth": "1100001001",
    "rot": "1100001010",
    "rotw": "1100001011",
    "shlhi": "1100001100",
    "sfh": "1100001101",
    "sfhs": "1100001110",
    "xor": "1100001111"}


tests = []

with open("program2.txt", "r") as input:
    data = input.readlines()
    for line in data:
        lst = list(filter(None, (re.split('\W+', line))))
        print(lst)

        # li format
        # li imm, offset(rd)
        if lst[0] == "li":
            op = "0" + format(int(lst[2])%0x8, "b").zfill(3) + format(int(lst[1])%0xFFFF, "b").zfill(16) + format(int(lst[3][1:])%0x1F, "b").zfill(5)

        # r4 format
        # op rd, rs1, rs2, rs3
        elif len(lst) == 5:
            op = ops[lst[0]] + format(int(lst[4][1:])%0x1F, "b").zfill(5) + format(int(lst[3][1:])%0x1F, "b").zfill(5) + format(int(lst[2][1:])%0x1F, "b").zfill(5) + \
                format(int(lst[1][1:])%0x1F, "b").zfill(5)

        # r3 format
        # op rd, rs1, rs2
        elif len(lst) == 4:
            op = ops[lst[0]] + format(int(lst[3][1:])%0x1F, "b").zfill(5) + format(int(lst[2][1:])%0x1F, "b").zfill(5) + format(int(lst[1][1:])%0x1F, "b").zfill(5)

        tests.append(op)


with open("stimulus.txt", "w") as output:
    for i in tests:
        output.write(i + "\n")
