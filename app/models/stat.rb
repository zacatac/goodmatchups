class Stat < ActiveRecord::Base
  @@api_key = 'ushjeuzyq2w9bpxqrmu3jdsp'

  def self.get_division(id)
    url = "http://api.sportsdatallc.org/ncaafb-t1/teams/FBS/2014/REG/standings.json?api_key=#{@@api_key}"
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object 
    return 'Error' if not ['200'].include?(resp.code)
    data = JSON.parse(resp.body)        
    div_raw = data['division']['conferences'][id]['teams']    

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
    matchups = Hash.new

    team_pairs.each do | t1, t2 |
      t1wpct = div[t1]['overall']['wpct']
      t2wpct = div[t2]['overall']['wpct']
      teams = [home,away].sort_by!{ |t| t }      
      matchups[teams] = (t1wpct - t2wpct).abs
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
