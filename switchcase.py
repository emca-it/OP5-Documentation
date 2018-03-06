#!/usr/bin/env python

import argparse
import requests
import json
import logging
import csv


def main():
    log_format = ':'.join(
        [
            '%(asctime)s',
            '%(levelname)s',
            '%(filename)s',
            '%(funcName)s',
            '%(lineno)s',
            '%(message)s',
        ]
    )
    logging.basicConfig(
        format=log_format,
        level=logging.INFO,
        filename="switchcase.log"
    )
    logger = logging.getLogger('switchcase')

    ssl_check = True
    description = "Switches the case of hosts in OP5 Monitor."
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument(
        "listfile",
        help="File containing the hosts."
    )
    parser.add_argument(
        "user",
        help="Account to log into OP5 Monitor."
    )
    parser.add_argument(
        "password",
        help="Account password for OP5 Monitor."
    )
    parser.add_argument(
        "-n",
        "--noop",
        action='store_false',
        help="Dry run, no operations are executed."
    )
    parser.add_argument(
        "-d",
        "--dest-url",
        dest='dest_url',
        default="https://localhost",
        help="The URL of the OP5 installation. Default: https://localhost"
    )
    parser.add_argument(
        '--nossl',
        action='store_true',
        help="Supress SSL warning."
    )
    parser.add_argument(
        '-l',
        '--lower',
        action='store_true',
        help="Switch case to lowercase."
    )
    parser.add_argument(
        '-u',
        '--upper',
        action='store_true',
        help="Switch case to uppercase."
    )
    args = parser.parse_args()

    print(args.lower)
    print(args.upper)

    if not args.lower or not args.upper:
        logger.error("No cases selected. Please, pick one.")
        return 10
    elif args.lower or args.upper:
        logger.error("Both cases selected. Please, pick one.")
        return 10

    if args.nossl:
        print("Supressing SSL warnings...")
        ssl_check = False
        requests.package.urllib3.disable_warnings()

    with open(args.listfile, 'rU') as hostlist:
        reader = csv.reader(hostlist, delimiter=',')
        for line in reader:
            if len(line) != 2:
                continue
            elif line[0] != line[1]:
                print(line)


    return 0

if __name__ == '__main__':
    main()
