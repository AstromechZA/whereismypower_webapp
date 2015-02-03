#!/usr/bin/env python
"""
Generate eskom loadshedding schedule v2 for Cape Town
In the following code, 'day' means the day of the month.. 1-31

Author: Ben Meier
Date: 02/02/2015
"""

import sys
import argparse
from datetime import datetime

times = [
    '00:00-02:30',
    '02:00-04:30',
    '04:00-06:30',
    '06:00-08:30',
    '08:00-10:30',
    '10:00-12:30',
    '12:00-14:30',
    '14:00-16:30',
    '16:00-18:30',
    '18:00-20:30',
    '20:00-22:30',
    '22:00-00:30'
]

def gen_stage_areas(day):
    '''
    Generate basic building block:
        which area is loadshed at each time in stage 1
    '''
    if day > 16:
        day -= 16
    i = ((day * 12 - 11) % 16) + (day - 1) / 4
    return [((a - 1) % 16) + 1 for a in xrange(i, i + 12)]

def combinations(day):
    """
    Generate the combinations of stage 1 days used for the given stage 4 day
    """
    m = ((day + 3) / 4) * 4
    return [ (a if a <= m else a - 4) for a in [day, day + 2, day + 1, day + 3]]

def combinations_for_stage(day, stage):
    """
    Cut down combinations to only those required for the current stage
    """
    return combinations(day)[:stage]

def blocks_for_day(day, stage):
    """
    Build list of areas per time for the given stage
    """
    dd = combinations_for_stage(day, stage)
    return zip(*[gen_stage_areas(d) for d in dd])

def times_per_day_per_stage(area, day, stage):
    """
    Determine which times the given stage is being load shed in the given day
    """
    m = zip(times, blocks_for_day(day, stage))
    return map(lambda x: x[0], filter(lambda x: area in x[1], m))

def main():
    parser = argparse.ArgumentParser(description=("Determine Cape Town's load "
        "shedding times for the given area on the given day, with the given stage."))
    parser.add_argument('area', type=int, help='Area code (1-16)')
    parser.add_argument('stage', type=int, help='Loadshedding Stage (1-4)')
    parser.add_argument('--day', type=int, required=False,
                        help='Day of the month. (Default: today)',
                        default=datetime.now().day)
    args = parser.parse_args()

    if args.area < 1 or args.area > 16:
        print 'Error: Area code out of range 1-16.'
        sys.exit(1)

    if args.stage < 1 or args.stage > 4:
        print 'Error: Stage code out of range 1-4.'
        sys.exit(1)

    if args.day < 1 or args.day > 31:
        print 'Error: Stage code out of range 1-31.'
        sys.exit(1)

    for t in times_per_day_per_stage(args.area, args.day, args.stage):
        print t

if __name__ == '__main__':
    main()
