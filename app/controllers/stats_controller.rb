class StatsController < ApplicationController
  require 'net/http'
  # GET /stats
  # GET /stats.json
  def index
    @stats = Stat.all()

    render json: @stats
  end

  # GET /stats/1
  # GET /stats/1.json
  def show    
    div = Stat.get_division(params[:id].to_i)    
    if div.eql? 'Error'
      return render json: {'error' => div}
    end
    matchups = Stat.get_matchups(div)
    
    render json: {'div' => div, 'matchups' => matchups}
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
