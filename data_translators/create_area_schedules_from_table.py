import re
from sets import Set

from collections import defaultdict

data = """00:00 to 02:30    9, 1, 15, 7     2, 15, 7, 9     13, 7, 10, 2    7, 10, 4, 13    7, 4, 14, 10    7, 14, 1, 12    7, 14, 1, 12
02:00 to 04:30  10, 2, 16, 8    3, 16, 8, 10    14, 8, 11, 3    8, 11, 1, 14    8, 1, 15, 11    8, 15, 2, 9     8, 15, 2, 9
04:00 to 06:30  11, 3, 13, 5    4, 13, 5, 11    15, 5, 12, 4    5, 12, 2, 15    5, 2, 16, 12    5, 16, 3, 10    5, 16, 3, 10
06:00 to 08:30  1, 16, 6, 14    9, 6, 14, 3     6, 14, 3, 11    14, 3, 11, 8    3, 11, 8, 9     11, 1, 9, 6     11, 1, 9, 6
08:00 to 10:30  2, 10, 7, 15    10, 7, 15, 4    7, 15, 4, 12    15, 4, 12, 1    4, 12, 1, 10    12, 2, 10, 7    12, 2, 10, 7
10:00 to 12:30  3, 11, 8, 16    11, 8, 16, 5    8, 16, 5, 13    16, 5, 13, 2    5, 13, 2, 11    13, 3, 11, 8    13, 3, 11, 8
12:00 to 14:30  4, 12, 1, 9     12, 1, 9, 6     1, 9, 6, 14     9, 6, 16, 3     6, 14, 3, 12    14, 4, 12, 1    14, 4, 12, 1
14:00 to 16:30  5, 13, 2, 10    13, 2, 10, 7    2, 10, 7, 15    10, 7, 15, 5    7, 15, 4, 13    15, 5, 13, 2    15, 5, 13, 2
16:00 to 18:30  6, 14, 3, 11    14, 3, 11, 8    3, 11, 8, 16    11, 8, 14, 4    8, 16, 5, 14    16, 6, 14, 3    16, 6, 14, 3
18:00 to 20:30  7, 15, 4, 12    15, 4, 12, 1    4, 12, 1, 9     12, 1, 9, 6     1, 9, 6, 15     9, 7, 15, 4     9, 7, 15, 4
20:00 to 22:30  8, 9, 5, 13     16, 5, 13, 2    5, 13, 2, 10    13, 2, 10, 7    2, 10, 7, 16    10, 8, 16, 5    10, 8, 16, 5
22:00 to 24:30  12, 4, 14, 6    1, 14, 6, 12    16, 6, 9, 1     6, 9, 3, 16     6, 3, 13, 9     6, 13, 4, 11    6, 13, 4, 11
"""

schedule_name = 'schedule3B'

linere = re.compile(r'(\d\d\:\d\d) to (\d\d\:\d\d)((?:\s+(?:\d+\, )*\d+)*)')

days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']

outage_data = defaultdict(lambda: defaultdict(list))

for line in data.splitlines():

    r = linere.match(line)
    if r is not None:

        tfrom = r.group(1)
        tto = r.group(2)

        tto_hour, tto_minute = tto.split(':')
        tto_hour = int(tto_hour)
        tto_minute = int(tto_minute)

        bad_span = tto_hour > 23 and tto_minute > 0
        actual_tto = '00:00' if bad_span else tto

        tstring = "%s-%s" % (tfrom, actual_tto)

        temp = r.group(3).strip().replace(', ', ',')

        if len(temp) > 0:
            day_data = re.sub(r'\s+', ' ', temp).split(' ')
            assert len(day_data) == 0 or len(day_data) == 7

            if len(day_data) == 7:

                outtages = zip(days, day_data)
                for p in outtages:

                    areas = p[1].split(',')
                    for a in areas:

                        outage_data[a][p[0]].append(tstring)

                if bad_span:
                    tstring = "00:00-%02d:%02d" % (tto_hour - 24, tto_minute)

                    outtages = zip(days[-6:] + [days[0]], day_data)
                    for p in outtages:

                        areas = p[1].split(',')
                        for a in areas:

                            outage_data[a][p[0]].insert(0, tstring)

# AreaSchedule.create(
#   area: area11,
#   schedule: schedule3B,
#   monday_outtages: '00:00-00:30|04:00-06:30|10:00-12:30|16:00-18:30',
#   tuesday_outtages: '04:00-06:30|10:00-12:30|16:00-18:30',
#   wednesday_outtages: '02:00-04:30|06:00-08:30|16:00-18:30',
#   thursday_outtages: '02:00-04:30|06:00-08:30|16:00-18:30',
#   friday_outtages: '02:00-04:30|06:00-08:30|10:00-12:30',
#   saturday_outtages: '06:00-08:30|10:00-12:30|22:00-00:00',
#   sunday_outtages: '00:00-00:30|06:00-08:30|10:00-12:30|22:00-00:00',
# )

for k in outage_data.keys():
    print "AreaSchedule.create("
    print "  area: area%s," % k
    print "  schedule: %s," % schedule_name
    print "  monday_outtages: '%s'," % '|'.join(outage_data[k]['monday'])
    print "  tuesday_outtages: '%s'," % '|'.join(outage_data[k]['tuesday'])
    print "  wednesday_outtages: '%s'," % '|'.join(outage_data[k]['wednesday'])
    print "  thursday_outtages: '%s'," % '|'.join(outage_data[k]['thursday'])
    print "  friday_outtages: '%s'," % '|'.join(outage_data[k]['friday'])
    print "  saturday_outtages: '%s'," % '|'.join(outage_data[k]['saturday'])
    print "  sunday_outtages: '%s'" % '|'.join(outage_data[k]['sunday'])
    print ")"
    print ""

