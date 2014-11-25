class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    
    render json: @teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    render json: @team
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      head :no_content
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    head :no_content
  end

  # GET /teams/query/1
  # GET /teams/query/1.json
  def query
    @teams = Team.where(:division_id => params[:id])

    render json: @teams
  end

  private
    
    def team_params
      params.require(:team).permit(:name, :win, :loss, :division_id)
    end
end
