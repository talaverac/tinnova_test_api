class Beers::Create
  include Interactor

  def call
    begin
      beers = context.beers_data
      user = context.user

      array_ids = []
      beers.each do |beer|
        array_ids << beer['id']
        beer = Beer.find_or_create_by(
          beer_id: beer['id'],
          name: beer['name'], 
          tagline:  beer['tagline'], 
          description: beer['description'], 
          abv: beer['abv'], 
          user: user)
        beer.update!(seen_at: Time.now)
      end
      
      context.beers = Beer.where(:beer_id => array_ids)
    rescue => e
      handle_error('Error inesperado', 500, e)
    end
  end

end