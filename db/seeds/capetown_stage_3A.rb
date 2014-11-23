cape_town = Region.find_by(name: 'Cape Town')

schedule3A = Schedule.create(name: 'Stage 3A', region: cape_town, description: 'Severe')

AreaSchedule.create(
  area: Area.find_by(name: 'Area 11'),
  schedule: schedule3A,
  monday_outtages: '04:00-06:30|10:00-12:30',
  tuesday_outtages: '10:00-12:30|16:00-18:30',
  wednesday_outtages: '16:00-18:30',
  thursday_outtages: '02:00-04:30|06:00-08:30|16:00-18:30',
  friday_outtages: '06:00-08:30',
  saturday_outtages: '06:00-08:30|10:00-12:30',
  sunday_outtages: '06:00-08:30|10:00-12:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 10'),
  schedule: schedule3A,
  monday_outtages: '02:00-04:30|08:00-10:30',
  tuesday_outtages: '08:00-10:30|14:00-16:30',
  wednesday_outtages: '14:00-16:30',
  thursday_outtages: '00:00-02:30|14:00-16:30|20:00-22:30',
  friday_outtages: '20:00-22:30',
  saturday_outtages: '08:00-10:30|20:00-22:30',
  sunday_outtages: '08:00-10:30|20:00-22:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 13'),
  schedule: schedule3A,
  monday_outtages: '00:00-00:30|14:00-16:30',
  tuesday_outtages: '04:00-06:30|14:00-16:30|20:00-22:30',
  wednesday_outtages: '00:00-02:30|20:00-22:30',
  thursday_outtages: '10:00-12:30|20:00-22:30',
  friday_outtages: '10:00-12:30',
  saturday_outtages: '10:00-12:30|14:00-16:30|22:00-00:00',
  sunday_outtages: '00:00-00:30|10:00-12:30|14:00-16:30|22:00-00:00'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 12'),
  schedule: schedule3A,
  monday_outtages: '12:00-14:30|22:00-00:00',
  tuesday_outtages: '00:00-00:30|12:00-14:30|18:00-20:30',
  wednesday_outtages: '18:00-20:30',
  thursday_outtages: '04:00-06:30|08:00-10:30|18:00-20:30',
  friday_outtages: '08:00-10:30',
  saturday_outtages: '08:00-10:30|12:00-14:30',
  sunday_outtages: '08:00-10:30|12:00-14:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 15'),
  schedule: schedule3A,
  monday_outtages: '18:00-20:30',
  tuesday_outtages: '00:00-02:30|08:00-10:30|18:00-20:30',
  wednesday_outtages: '04:00-06:30|08:00-10:30',
  thursday_outtages: '08:00-10:30|14:00-16:30',
  friday_outtages: '14:00-16:30',
  saturday_outtages: '02:00-04:30|14:00-16:30|18:00-20:30',
  sunday_outtages: '02:00-04:30|14:00-16:30|18:00-20:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 14'),
  schedule: schedule3A,
  monday_outtages: '16:00-18:30',
  tuesday_outtages: '06:00-08:30|16:00-18:30|22:00-00:00',
  wednesday_outtages: '00:00-00:30|02:00-04:30|06:00-08:30',
  thursday_outtages: '06:00-08:30|16:00-18:30',
  friday_outtages: '12:00-14:30',
  saturday_outtages: '00:00-02:30|12:00-14:30|16:00-18:30',
  sunday_outtages: '00:00-02:30|12:00-14:30|16:00-18:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 16'),
  schedule: schedule3A,
  monday_outtages: '06:00-08:30',
  tuesday_outtages: '02:00-04:30|10:00-12:30|20:00-22:30',
  wednesday_outtages: '10:00-12:30|22:00-00:00',
  thursday_outtages: '00:00-00:30|10:00-12:30|12:00-14:30',
  friday_outtages: '16:00-18:30',
  saturday_outtages: '04:00-06:30|16:00-18:30|20:00-22:30',
  sunday_outtages: '04:00-06:30|16:00-18:30|20:00-22:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 1'),
  schedule: schedule3A,
  monday_outtages: '00:00-02:30|06:00-08:30|12:00-14:30',
  tuesday_outtages: '12:00-14:30|22:00-00:00',
  wednesday_outtages: '00:00-00:30|12:00-14:30|18:00-20:30',
  thursday_outtages: '18:00-20:30',
  friday_outtages: '02:00-04:30|08:00-10:30|18:00-20:30',
  saturday_outtages: '06:00-08:30',
  sunday_outtages: '06:00-08:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 3'),
  schedule: schedule3A,
  monday_outtages: '04:00-06:30|10:00-12:30|16:00-18:30',
  tuesday_outtages: '02:00-04:30|16:00-18:30',
  wednesday_outtages: '06:00-08:30|16:00-18:30',
  thursday_outtages: '06:00-08:30',
  friday_outtages: '06:00-08:30|12:00-14:30|22:00-00:00',
  saturday_outtages: '00:00-00:30|10:00-12:30',
  sunday_outtages: '10:00-12:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 2'),
  schedule: schedule3A,
  monday_outtages: '02:00-04:30|08:00-10:30|14:00-16:30',
  tuesday_outtages: '00:00-02:30|14:00-16:30',
  wednesday_outtages: '14:00-16:30|20:00-22:30',
  thursday_outtages: '20:00-22:30',
  friday_outtages: '04:00-06:30|10:00-12:30|20:00-22:30',
  saturday_outtages: '08:00-10:30',
  sunday_outtages: '08:00-10:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 5'),
  schedule: schedule3A,
  monday_outtages: '14:00-16:30|20:00-22:30',
  tuesday_outtages: '20:00-22:30',
  wednesday_outtages: '04:00-06:30|10:00-12:30|20:00-22:30',
  thursday_outtages: '04:00-06:30|10:00-12:30',
  friday_outtages: '04:00-06:30|10:00-12:30|16:00-18:30',
  saturday_outtages: '04:00-06:30|14:00-16:30',
  sunday_outtages: '04:00-06:30|14:00-16:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 4'),
  schedule: schedule3A,
  monday_outtages: '12:00-14:30|18:00-20:30|22:00-00:00',
  tuesday_outtages: '00:00-00:30|04:00-06:30|18:00-20:30',
  wednesday_outtages: '08:00-10:30|18:00-20:30',
  thursday_outtages: '08:00-10:30',
  friday_outtages: '00:00-02:30|08:00-10:30|14:00-16:30',
  saturday_outtages: '12:00-14:30',
  sunday_outtages: '12:00-14:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 7'),
  schedule: schedule3A,
  monday_outtages: '08:00-10:30|18:00-20:30',
  tuesday_outtages: '08:00-10:30',
  wednesday_outtages: '00:00-02:30|08:00-10:30|14:00-16:30',
  thursday_outtages: '00:00-02:30|14:00-16:30',
  friday_outtages: '00:00-02:30|14:00-16:30|20:00-22:30',
  saturday_outtages: '00:00-02:30|18:00-20:30',
  sunday_outtages: '00:00-02:30|18:00-20:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 6'),
  schedule: schedule3A,
  monday_outtages: '00:00-00:30|06:00-08:30|16:00-18:30',
  tuesday_outtages: '06:00-08:30',
  wednesday_outtages: '06:00-08:30|12:00-14:30|22:00-00:00',
  thursday_outtages: '00:00-00:30|12:00-14:30|22:00-00:00',
  friday_outtages: '00:00-00:30|12:00-14:30|18:00-20:30|22:00-00:00',
  saturday_outtages: '00:00-00:30|16:00-18:30|22:00-00:00',
  sunday_outtages: '00:00-00:30|16:00-18:30|22:00-00:00'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 9'),
  schedule: schedule3A,
  monday_outtages: '00:00-02:30|20:00-22:30',
  tuesday_outtages: '06:00-08:30|12:00-14:30',
  wednesday_outtages: '12:00-14:30',
  thursday_outtages: '12:00-14:30|18:00-20:30|22:00-00:00',
  friday_outtages: '00:00-00:30|18:00-20:30',
  saturday_outtages: '06:00-08:30|18:00-20:30',
  sunday_outtages: '06:00-08:30|18:00-20:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 8'),
  schedule: schedule3A,
  monday_outtages: '10:00-12:30|20:00-22:30',
  tuesday_outtages: '10:00-12:30',
  wednesday_outtages: '02:00-04:30|10:00-12:30|16:00-18:30',
  thursday_outtages: '02:00-04:30|16:00-18:30',
  friday_outtages: '02:00-04:30|06:00-08:30|16:00-18:30',
  saturday_outtages: '02:00-04:30|20:00-22:30',
  sunday_outtages: '02:00-04:30|20:00-22:30'
)
