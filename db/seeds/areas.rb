ActiveRecord::Base.transaction do
  Area.create(
    name: 'Area 1',
    long_name: 'Bellville',
    code: 1
  )
  Area.create(
    name: 'Area 2',
    long_name: 'Maitland, Milnerton',
    code: 2
  )
  Area.create(
    name: 'Area 3',
    long_name: 'Somerset West, Strand',
    code: 3
  )
  Area.create(
    name: 'Area 4',
    long_name: 'Mitchells Plain, Philippi',
    code: 4
  )
  Area.create(
    name: 'Area 5',
    long_name: 'Newlands, Parts of Rondebosch, Ottery, Hanover Park',
    code: 5
  )
  Area.create(
    name: 'Area 6',
    long_name: 'Durbanville, Tygervalley, Welgemoed',
    code: 6
  )
  Area.create(
    name: 'Area 7',
    long_name: 'City Bowl, Green Point, Seapoint, Camps Bay',
    code: 7
  )
  Area.create(
    name: 'Area 8',
    long_name: 'Cape Peninsula, Tokai, Muizenberg',
    code: 8
  )
  Area.create(
    name: 'Area 9',
    long_name: 'Pinelands, Langa, Epping',
    code: 9
  )
  Area.create(
    name: 'Area 10',
    long_name: 'Brackenfell, Kuilsriver, Kraaifontein, Vredekloof',
    code: 10
  )
  Area.create(
    name: 'Area 11',
    long_name: 'Hout Bay, Constantia, Bergvliet, Plumstead, Wynberg, Claremont',
    code: 11
  )
  Area.create(
    name: 'Area 12',
    long_name: 'Athlone, Manenberg',
    code: 12
  )
  Area.create(
    name: 'Area 13',
    long_name: 'Delft, Blue Downs, Goodwood, Parow',
    code: 13
  )
  Area.create(
    name: 'Area 14',
    long_name: 'Atlantis, Bouberg',
    code: 14
  )
  Area.create(
    name: 'Area 15',
    long_name: 'Observatory, Rondebosch, Maitland',
    code: 15
  )
  Area.create(
    name: 'Area 16',
    long_name: 'Retreat, Philippi',
    code: 16
  )
end
