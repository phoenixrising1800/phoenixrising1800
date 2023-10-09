#!/usr/bin/env python

""" Python script to get magic file number bytes out of a file """
import sys

magic_numbers = {
        'png': bytes([0x89, 0x50, 0x4E, 0x47]),
        'png': bytes([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]),
        'jpg': bytes([0xFF, 0xD8, 0xFF, 0xE0]),
        'jpgExif': bytes([0xFF, 0xD8, 0xFF, 0xE1]),
        #*********************#
        'gif': bytes([0x47, 0x49, 0x46, 0x38]),
        #*********************#
        'doc': bytes([0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1]),
        'xls': bytes([0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1]), 
        'ppt': bytes([0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1]),
        #*********************#
        'docx': bytes([0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00]),
        'xlsx': bytes([0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00]),
        'pptx': bytes([0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00]),
        #*********************#
        'pdf': bytes([0x25, 0x50, 0x44, 0x46]),
        #*********************#
        'dll': bytes([0x4D, 0x5A, 0x90, 0x00]),
        'exe': bytes([0x4D, 0x5A]),
        #*********************#
        'pcap': bytes([0x4D, 0x3C, 0xB2, 0xA1]),
        'pcap': bytes([0xA1, 0xB2, 0x3C, 0x4D]),
        'pcapng': bytes([0x0A, 0x0D, 0x0D, 0x0A])
}

def get_hex(magic_bytes: bytes) -> str:
    # Print hex interp.
    hexArr = []
    arr = bytearray(magic_bytes)
    print("Magic Bytes: ", end="")
    for a in arr:
        hx = hex(a)
        hexArr.append(a)
        print(hx[2:].upper() + ' ', end='') # Don't print leading 0x
    return hexArr 

# Print dec interp.
def print_ints(magic_bytes: bytes): 
    print('   [ ', end='')
    f"{[b for b in magic_bytes if print(f'{b} ', end='')]}"
    print(']')


def main(args):
    import sys
    from pathlib import Path

    typeList = [] # in case magic numbers match multiple types

    if len(sys.argv) != 2:
        print("Program needs only 1 file argument")
        sys.exit(0)

    path = sys.argv[1]
    obj = Path(path)

    if not obj.exists():
        print("Program needs a valid file - exiting.")

    # Read the 4 magic bytes
    with open(obj, 'rb') as f:
        magic_bytes = f.read(4) #bytes

        # Print hex interp.
        hexArr = get_hex(magic_bytes)
        hexArr = bytes(hexArr)

        # Print dec interp.
        print_ints(magic_bytes)

        print('HexArr of file: ' + str(hexArr))
        for key,value in magic_numbers.items():
            #print(f'Key: {key}, Value: {str(value)}')
            if hexArr == value or hexArr in value:
                print("File is: " + key)
                typeList.append(key)
    
        if len(typeList) > 1:
            print("File is most likely a ZIP")
            
if __name__ == '__main__':
    main(sys.argv)
