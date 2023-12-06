import sys
import re

def main():
    if len(sys.argv) < 2:
        print("Usage python process_results.py results.txt")
        return

    resultsFile = open(sys.argv[1])
    lines = resultsFile.readlines()

    total = 0
    count = 0
    non_decimal = re.compile(r'[^\d.]+')
    for line in lines:
        if 'ns/iter' in line:
            line = line.split('ns/iter')
            line = line[0].split()
            result = line[-1]
            total += int(non_decimal.sub('',result))
            count += 1

    print("Result: ", total/count, count)


main()
