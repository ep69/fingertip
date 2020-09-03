# Licensed under GNU General Public License v3 or later, see COPYING.
# Copyright (c) 2020 Red Hat, Inc., see CONTRIBUTORS.

import numbers

TIME = {'s': 1, 'm': 60, 'h': 3600, 'd': 24 * 3600, 'w': 24 * 3600 * 7}
BINARY = {'K': 2**10, 'M': 2**20, 'G': 2**30, 'T': 2**40, 'P': 2**50}


def parse_time_interval(interval):
    if isinstance(interval, str) and interval[-1] in TIME:
        return float(interval[:-1]) * TIME[interval[-1]]
    if isinstance(interval, numbers.Real) and not isinstance(interval, bool):
        return float(interval)
    raise ValueError(f'Cannot parse time interval {interval}')


def parse_binary(value):
    if isinstance(value, str) and value[-1] in BINARY:
        return int(value[:-1]) * BINARY[value[-1]]
    try:
        return int(value)
    except ValueError:
        raise ValueError(f'Cannot parse binary-suffixed value {value}')


def binary(value):
    value = int(value)
    for suffix, suffix_value in BINARY.items():
        if value >= suffix_value:
            break
    return f'{int(value / suffix_value)}{suffix}'