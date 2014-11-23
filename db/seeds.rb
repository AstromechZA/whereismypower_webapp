cape_town = Region.create(
  name: 'Cape Town',
  long_name: 'Greater Cape Town Area'
)

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
