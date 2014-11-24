class DivisionsController < ApplicationController
  # GET /divisions
  # GET /divisions.json
  def index
    @divisions = Division.all

    render json: @divisions
  end

  # GET /divisions/1
  # GET /divisions/1.json
  def show
    @division = Division.find(params[:id])

    render json: @division
  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(division_params)

    if @division.save
      render json: @division, status: :created, location: @division
    else
      render json: @division.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /divisions/1
  # PATCH/PUT /divisions/1.json
  def update
    @division = Division.find(params[:id])

    if @division.update(division_params)
      head :no_content
    else
      render json: @division.errors, status: :unprocessable_entity
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division = Division.find(params[:id])
    @division.destroy

    head :no_content
  end

  private
    
    def division_params
      params.require(:division).permit(:name)
    end
end
