class BeersController < ApplicationController  
  before_action :authenticate!

  def index
    render json: {
        hello: @current_user.name
    }
  end

  # beers_list(verb: 'POST', description: 'Crea lista de cervezas que ha visto el current user')
  def beers_list
  	@url = 'https://api.punkapi.com/v2/beers'    		
  	response = RestClient.get beer_url
  	json_response = JSON.parse response.body

  	create_list = ::Beers::Create.call(
  		user: @current_user,
  		beers_data: json_response
  	)
  	
  	render json: create_list.beers, adapter: :json_api, each_serializer: BeerSerializer
  end

  # save_favorite_beer(verb: 'POST', description: 'Guarda la cerveza favorita del current user')
  def save_favorite_beer
  	return if favorite_beer_params.to_h.empty?
  	
  	beer = @current_user.beers.where(beer_id: favorite_beer_params['id']).try(:last)

    beer.update!(favorite: true) unless beer.nil?

    response = beer.nil? ? not_found_response : save_success_response(beer)

  	render response

  end  
 
  # my_favorite_beer(verb: 'GET', description: 'Despliega la cerveza favorita del current user')
  def my_favorite_beer
  	return if favorite_beer_params.to_h.empty?

  	favorite_beer = Beer.where(beer_id: favorite_beer_params['id'], favorite: true, user: @current_user).try(:last)

  	render json: favorite_beer, adapter: :json_api, serializer: BeerSerializer

  end
 
  # all_beers(verb: 'GET', description: 'Despliega las cervezas vistas current user')
  def all_beers
  	all_beers_beer = Beer.where(user: @current_user)

  	render json: all_beers_beer, adapter: :json_api, each_serializer: BeerSerializer

  end

  private

  def beer_url
    return @url if permitted_params.to_h.empty?
    url = "#{@url}?"
    permitted_params.to_h.each { |key, value| url += "#{key}=#{value}&" }
    url[0..-2]
  end

  def save_success_response(beer)
    {
      json: beer, adapter: :json_api, serializer: BeerSerializer
    }
  end

  def not_found_response
  	{
      json: {message: 'Esa cerveza no existe en la base de datos'},
      status: 500
    }
  	
  end

  def favorite_beer_params
  	@permitted_params ||= params.permit(:id)  	
  end

  def permitted_params
      @permitted_params ||= params.permit(
      	:abv_gt, :abv_lt, :ibu_gt, :ibu_lt, :ebc_gt, :ebc_lt, :beer_name, :yeast, :brewed_before, :hops,
        :malt, :food, :ids, :page, :per_page
      	)
  end
end
