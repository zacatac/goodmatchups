class Stat < ActiveRecord::Base
  serialize :data, JSON

  # @@api_key = 'ushjeuzyq2w9bpxqrmu3jdsp' # USed Nov quota
  @@api_key = 'z2fggfbfa7qg976dubxmgc73'

  def self.get_division(id, label)    
    if id < 0 || id > 11
      return 'Error'
    end

    @stats = Stat.where(:division_id => id)
    if @stats.empty?   
      label_to_index = {
        'ACC' => 0,
        'AAC' => 1,      
        'BIG-12' => 2,
        'BIG-TEN' => 3,
        'CONFERENCE-USA' => 4,
        'IA-INDEPENDENTS' => 5,
        'MID-AMERICAN' => 6,
        'MOUNTAIN-WEST' => 7, 
        'PAC-12' => 8,
        'SEC' => 9,
        'SUN-BELT' => 10
      }

      puts 'API CALLED'
      url = "http://api.sportsdatallc.org/ncaafb-t1/teams/FBS/2014/REG/standings.json?api_key=#{@@api_key}"
      resp = Net::HTTP.get_response(URI.parse(url))
      return 'Error' if not ['200'].include?(resp.code)
      data = JSON.parse(resp.body)        
      div_raw = data['division']['conferences'][label_to_index[label]]['teams']    
      @stat = Stat.create({
                            data: div_raw,
                            division_id: id
                          })
      if not @stat.save
        return 'Error'
      end

    else       
      @stat = @stats[0]
    end
    div_raw = @stat['data']
    div = Hash.new
    div_raw.each do |team|      
      div[team['id']] = {
        'name' => team['name'], 
        'overall' => team['overall'],
        'home' => team['home'],
        'away' => team['away'],
        'points' => team['points'],
      }      
    end
    return div
  end

  def self.get_matchups(div)
    # Orders best matchups across
    # a division by the absolute value 
    # of the difference between
    # the two teams wpct
    teams = div.keys
    team_pairs = teams.combination(2).to_a
    matchups = []

    team_pairs.each do | t1, t2 |
      t1wpct = div[t1]['overall']['wpct']
      t2wpct = div[t2]['overall']['wpct']
      teams = [div[t1]['name'],div[t2]['name']].sort_by!{ |t| t }                 
      matchups.push ( {
        "teams" => teams,
        "score" => (t1wpct - t2wpct).abs
      })
    end
    return matchups
  end

  def self.get_dense_matchups(div)
    # This method can be used to 
    # get a better approximation of which 
    # matchups might me the most exciting
    # It takes into account the scores from 
    # previous games. The lower the difference 
    # between scores across many games, the 
    # more likely it will be that the next game
    # will also be close
    teams = div.keys
    team_pairs = teams.combination(2).to_a
    matchups = Hash.new    
    for year in 2013..2014
      season = 'REG'
      url = "http://api.sportsdatallc.org/ncaafb-t1/#{year}/#{season}/schedule.json?api_key=#{@@api_key}" 
      resp = Net::HTTP.get_response(URI.parse(url)) 
      data = JSON.parse(resp.body)
      data['weeks'].each do | week |
        week['games'].each do | game |          
          home = game["home"]
          away = game["away"]
          week_num = week["number"]
          teams = [home,away].sort_by!{ |t| t }
          url = "http://api.sportsdatallc.org/ncaafb-t1/#{year}/#{season}/#{week_num}/#{away}/#{home}/summary.json?api_key=#{@@api_key}" 
          resp = Net::HTTP.get_response(URI.parse(url)) 
          data = JSON.parse(resp.body)
          home_score = data["home_team"]["points"].to_i
          away_score = data["away_team"]["points"].to_i          
          if matchups.has_key?(teams)
            matchups[teams] += (home_score - away_score).abs
          else
            matchups[teams] = (home_score - away_score).abs
          end
        end
      end
    end
    return matchups
  end
end
