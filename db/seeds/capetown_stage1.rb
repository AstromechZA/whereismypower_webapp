cape_town = Region.find_by(name: 'Cape Town')

schedule1 = Schedule.create(name: 'Stage 1', region: cape_town)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 11'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '10:00-12:30',
  wednesday_outtages: '',
  thursday_outtages: '16:00-18:30',
  friday_outtages: '',
  saturday_outtages: '06:00-08:30',
  sunday_outtages: '06:00-08:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 10'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '08:00-10:30',
  wednesday_outtages: '',
  thursday_outtages: '14:00-16:30',
  friday_outtages: '',
  saturday_outtages: '20:00-22:30',
  sunday_outtages: '20:00-22:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 13'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '14:00-16:30',
  wednesday_outtages: '',
  thursday_outtages: '20:00-22:30',
  friday_outtages: '',
  saturday_outtages: '10:00-12:30',
  sunday_outtages: '10:00-12:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 12'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '12:00-14:30',
  wednesday_outtages: '',
  thursday_outtages: '18:00-20:30',
  friday_outtages: '',
  saturday_outtages: '08:00-10:30',
  sunday_outtages: '08:00-10:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 15'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '18:00-20:30',
  wednesday_outtages: '',
  thursday_outtages: '08:00-10:30',
  friday_outtages: '',
  saturday_outtages: '14:00-16:30',
  sunday_outtages: '14:00-16:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 14'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '16:00-18:30',
  wednesday_outtages: '',
  thursday_outtages: '06:00-08:30',
  friday_outtages: '',
  saturday_outtages: '12:00-14:30',
  sunday_outtages: '12:00-14:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 16'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '20:00-22:30',
  wednesday_outtages: '',
  thursday_outtages: '10:00-12:30',
  friday_outtages: '',
  saturday_outtages: '16:00-18:30',
  sunday_outtages: '16:00-18:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 1'),
  schedule: schedule1,
  monday_outtages: '06:00-08:30',
  tuesday_outtages: '',
  wednesday_outtages: '12:00-14:30',
  thursday_outtages: '',
  friday_outtages: '18:00-20:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 3'),
  schedule: schedule1,
  monday_outtages: '10:00-12:30',
  tuesday_outtages: '',
  wednesday_outtages: '16:00-18:30',
  thursday_outtages: '',
  friday_outtages: '06:00-08:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 2'),
  schedule: schedule1,
  monday_outtages: '08:00-10:30',
  tuesday_outtages: '',
  wednesday_outtages: '14:00-16:30',
  thursday_outtages: '',
  friday_outtages: '20:00-22:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 5'),
  schedule: schedule1,
  monday_outtages: '14:00-16:30',
  tuesday_outtages: '',
  wednesday_outtages: '20:00-22:30',
  thursday_outtages: '',
  friday_outtages: '10:00-12:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 4'),
  schedule: schedule1,
  monday_outtages: '12:00-14:30',
  tuesday_outtages: '',
  wednesday_outtages: '18:00-20:30',
  thursday_outtages: '',
  friday_outtages: '08:00-10:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 7'),
  schedule: schedule1,
  monday_outtages: '18:00-20:30',
  tuesday_outtages: '',
  wednesday_outtages: '08:00-10:30',
  thursday_outtages: '',
  friday_outtages: '14:00-16:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 6'),
  schedule: schedule1,
  monday_outtages: '16:00-18:30',
  tuesday_outtages: '',
  wednesday_outtages: '06:00-08:30',
  thursday_outtages: '',
  friday_outtages: '12:00-14:30',
  saturday_outtages: '',
  sunday_outtages: ''
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 9'),
  schedule: schedule1,
  monday_outtages: '',
  tuesday_outtages: '06:00-08:30',
  wednesday_outtages: '',
  thursday_outtages: '12:00-14:30',
  friday_outtages: '',
  saturday_outtages: '18:00-20:30',
  sunday_outtages: '18:00-20:30'
)

AreaSchedule.create(
  area: Area.find_by(name: 'Area 8'),
  schedule: schedule1,
  monday_outtages: '20:00-22:30',
  tuesday_outtages: '',
  wednesday_outtages: '10:00-12:30',
  thursday_outtages: '',
  friday_outtages: '16:00-18:30',
  saturday_outtages: '',
  sunday_outtages: ''
)
