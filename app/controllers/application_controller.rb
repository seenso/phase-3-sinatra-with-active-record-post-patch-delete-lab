class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  #GET
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  #POST
  post '/baked_goods' do
    #create
    baked_good = BakedGood.create(
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    )
    #return json response
    baked_good.to_json
  end

  #PATCH
  patch '/bakeries/:id' do
    #find bakery
    bakery = Bakery.all.find(params[:id])
    #.update() bakery
    bakery.update(
      name: params[:name]
    )
    #return response with updated bakery
    bakery.to_json
  end

  #DELETE
  delete '/baked_goods/:id' do
    #find
    baked_good = BakedGood.all.find(params[:id])
    #destroy
    baked_good.destroy
    #send response with deleted bakery
    baked_good.to_json
  end

end
