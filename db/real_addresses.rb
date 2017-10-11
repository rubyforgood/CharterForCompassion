class RealAddresses

  ADDRESSES = [
      ['100 Holliday St',          'Baltimore',     'MD', '21202'],
      ['4 South Market Building',  'Boston',        'MA', '02109'],
      ['233 S Wacker Dr',          'Chicago',       'IL', '60606'],
      ['2201 N Field St',          'Dallas',        'TX', '75201'],
      ['900 Exposition Blvd',      'Los Angeles',   'CA', '90007'],
      ['501 Marlins Way',          'Miami',         'FL', '33125'],
      ['350 Fifth Avenue',         'New York',      'NY', '10118'],
      ['520 Chestnut St',          'Philadelphia',  'PA', '19106'],
      ['151 3rd St',               'San Francisco', 'CA', '94103'],
      ['400 Broad St',             'Seattle',       'WA', '98109'],
      ['430 South 15th St.',       'St. Louis',     'MO', '63103-2607'],
      ['1600 Pennsylvania Ave NW', 'Washington',    'DC', '20500']
  ]

  def self.sample_array
    ADDRESSES.sample
  end

  def self.sample_hash
    street, city, state, zipcode = sample_array
    {
        street: street,
        city:    city,
        state:   state,
        zipcode: zipcode,
    }
  end

  def self.users_sample_hash
    street, city, state, zipcode = sample_array
    {
        street1: street,
        city:    city,
        state:   state,
        zipcode: zipcode,
    }
  end
end
