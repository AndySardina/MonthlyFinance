#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import sys
import logging

from generators import __version__
from generators.impl import *


__author__ = "Andy Sardina"
__copyright__ = "Andy Sardina"
__license__ = "mit"

log = logging.getLogger(__name__)


def parse_args(args):
    """Parse command line parameters

    Args:
      args ([str]): command line parameters as list of strings

    Returns:
      :obj:`argparse.Namespace`: command line parameters namespace
    """
    parser = argparse.ArgumentParser(
        description="Small set of utilities to generate SQL inserts with information of countries, languages "
                    "and currencies.")
    parser.add_argument(
        '--version',
        action='version',
        version='Entity generators version {ver}'.format(ver=__version__)
    )
    parser.add_argument(
        '-e',
        '--entity-type',
        dest="entity",
        help="Specify the type of entity to generate. Currently supported: [currency]",
        type=str,
        metavar="entity-type"
    )
    parser.add_argument(
        '-o',
        '--output-dir',
        dest="output_dir",
        help="Specify the type of entity to generate. Currently supported: [currency, language]",
        type=str,
        metavar="output-dir"
    )
    parser.add_argument(
        '-v',
        '--verbose',
        dest="loglevel",
        help="Set the log level to DEBUG",
        action='store_const',
        const=logging.DEBUG
    )

    return parser.parse_args(args)


def setup_logging(level):
    """Setup basic logging

    Args:
      level (int): minimum loglevel for emitting messages
    """
    log_format = "[%(asctime)s] %(levelname)s %(name)s  %(message)s"
    log_level = level if level is not None else logging.INFO
    logging.basicConfig(level=log_level, stream=sys.stdout, format=log_format, datefmt="%Y-%m-%d %H:%M:%S")


def main(args):
    """Main entry point allowing external calls

    Args:
      args ([str]): command line parameter list
    """
    args = parse_args(args)
    setup_logging(args.loglevel)

    generators = {
        "currency": currencies_generator,
        "language": languages_generator,
        "country" : countries_generator
    }

    log.info("Using the {} generator to create the SQL script.".format(args.entity))

    generators[args.entity].generate(args.output_dir)


def run():
    """Entry point for console_scripts
    """
    main(sys.argv[1:])


if __name__ == "__main__":
    run()
