#!/usr/bin/python3

ops = {
    "simals" : 0b1000000000000000000000000,
    "simahs" : 0b1000100000000000000000000,
    "simsls" : 0b1001000000000000000000000,
    "simshs" : 0b1001100000000000000000000,
    "slimals" : 0b1010000000000000000000000,
    "slimahs" : 0b1010100000000000000000000,
    "slimsls" : 0b1011000000000000000000000,
    "slimshs" : 0b1011100000000000000000000,
    "nop" : 0b1100000000000000000000000,
    "ah" : 0b1100000001000000000000000,
    "ahs" : 0b1100000010000000000000000,
    "bcw" : 0b1100000011000000000000000,
    "cgh" : 0b1100000100000000000000000,
    "clz" : 0b1100000101000000000000000,
    "max" : 0b1100000110000000000000000,
    "min" : 0b1100000111000000000000000,
    "msgn" : 0b1100001000000000000000000,
    "popcnth" : 0b1100001001000000000000000,
    "rot" : 0b1100001010000000000000000,
    "rotw" : 0b1100001011000000000000000,
    "shlhi" : 0b1100001100000000000000000,
    "sfh" : 0b1100001101000000000000000,
    "sfhs" : 0b1100001110000000000000000,
    "xor" : 0b1100001111000000000000000}



tests = []

with open("program.txt", "r") as input:
    data = input.readlines()
    for line in data:
        lst = line.split()
        if len(lst) < 5:
            print(f"format error\n")
            exit(1)
        else:
            tests.append((format(ops[lst[0]], "b").zfill(25), \
                format(int(lst[1]), "b").zfill(128), \
                format(int(lst[2]), "b").zfill(128), \
                format(int(lst[3]), "b").zfill(128), \
                format(int(lst[4]), "b").zfill(128)))

with open("stimulus.txt", "w") as output:
    for i in tests:
        for j in i:
            output.write(j + " ")
        output.write("\n")