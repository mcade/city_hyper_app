class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
    #@instagram = Instagram.user_recent_media("254328524", {:count => 1})
    #@instagram = Instagram.location_recent_media(514276)

    if params[:search].present?
      result = Geocoder.coordinates(params[:search])
      if result.present?
        @instagram =  Instagram.media_search(result.first,result.last, {:count => 30})
        @twitter = $twitter.search("geocode:#{result.first},#{result.last},10km", :result_type => "recent").take(30)
     
        @coord1 = result.first
        @coord2 = result.last
      else 
      
      end
    else
      result = Geocoder.coordinates("Chicago")
      if result.present?
        @instagram =  Instagram.media_search(result.first,result.last, {:count => 30})
   
        @twitter = $twitter.search("geocode:#{result.first},#{result.last},10km", :result_type => "recent").take(30)
        @coord1 = result.first
        @coord2 = result.last
      else 
      
      end
    end

    


  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :country)
    end
end
