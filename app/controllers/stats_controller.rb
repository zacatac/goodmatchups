class StatsController < ApplicationController
  require 'net/http'
  # GET /stats
  # GET /stats.json
  def index
    url = 'http://api.sportsdatallc.org/ncaafb-t1/teams/FBS/2014/REG/standings.json?api_key=ushjeuzyq2w9bpxqrmu3jdsp'
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
    data = resp.body
    data = JSON.parse(data)    
    pac12raw = data['division']['conferences'][8]['teams']    
    pac12 = Hash.new
    pac12raw.each do |team|
      pac12[team['id']] = [team['name'], team['overall']]
    end
    render json: pac12
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
    url = 'http://api.sportsdatallc.org/ncaafb-t1/teams/FBS/2014/REG/standings.json?api_key=ushjeuzyq2w9bpxqrmu3jdsp'
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
    data = resp.body
    data = JSON.parse(data)        
    div_raw = data['division']['conferences'][params[:id].to_i]['teams']    
    div = Hash.new
    div_raw.each do |team|
      div[team['id']] = [team['name'], team['overall']]
    end
    render json: div

    # @stat = Stat.find(params[:id])
    
    # render json: @stat
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(stat_params)

    if @stat.save
      render json: @stat, status: :created, location: @stat
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    @stat = Stat.find(params[:id])

    if @stat.update(stat_params)
      head :no_content
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat = Stat.find(params[:id])
    @stat.destroy

    head :no_content
  end

  private
    
    def stat_params
      params[:stat]
    end
end
