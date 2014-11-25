# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ACC = Division.create({ 
                        name: 'Atlantic Coast',
                        label: 'ACC'
                      })
AAC = Division.create({ 
                        name: 'American Athletic',
                        label: 'AAC'
                      })

CUSA = Division.create({
                         name:'Conference USA',
                         label:'CONFERENCE-USA'
                       })
B10C = Division.create({ 
                         name: 'Big Ten' ,
                         label: 'BIG-TEN'
                       })

B12C = Division.create({ 
                         name: 'Big 12',
                         label: 'BIG-12'
                       })

P12C = Division.create({ 
                         name:'Pacific-12',
                         label:'PAC-12'
                       })

SEC = Division.create({ 
                        name: 'SEC',
                        label: 'SEC'
                      })
IA = Division.create({
                       name: 'IA Independents',
                       label: 'IA-INDEPENDENTS'
                     })
MA = Division.create({
                       name: 'Mid-American',
                       label: 'MID-AMERICAN'
                     })
MW = Division.create({
                       name: 'Mountain West',
                       label: 'MOUNTAIN-WEST'
                     })
SB = Division.create({
                       name: 'Sun Belt',
                       label: 'SUN-BELT'
                     })
Team.create([
             { label:'ORE',
               name:'Ducks',
               division: P12C },
             { label:'ASU',
               name:'Sun Devils',
               division: P12C },
             { label:'UCLA',
               name:'Bruins',
               division: P12C },
             { label:'ARI',
               name:'Wildcats',
               division: P12C },
             { label:'USC',
               name:'Trojans',
               division: P12C },
             { label:'UTH',
               name:'Utes',
               division: P12C },
             { label:'WAS',
               name:'Huskies',
               division: P12C },
             { label:'STA',
               name:'Cardinal',
               division: P12C },
             { label:'CAL',
               name:'Bears',
               division: P12C },
             { label:'ORS',
               name:'Beavers',
               division: P12C },
             { label:'WST',
               name:'Cougars',
               division: P12C },
             { label:'COL',
               name:'Buffaloes',
               division: P12C }
            ])
