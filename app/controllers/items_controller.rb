class ItemsController < ApplicationController
    # 1.  get method to return all the items 
    def index 
        # Index will only render not sold items here
        item = Item.where(sold: false)
        if item 
            render json: item 
        else 
            render json: {error: 'Items currently not availables we are working in this issue deeply apologies for the inconvenience'}, status_code: :not_found
        end

    end

    def show
        # render one specific item 
        item = Item.find_by(id: params[:id])
        if item 
            render json: item 
        else
            render json: {error: error.full_messages}, status_code: :not_found  
        
        end

    end

    def create  
        #current user is creating items using sold_items association check user model to confirm
        item = current_user.sold_items.create(item_params)
        if item.valid?
            render json: item, status: :created 
        else
            render json: {error: item.errors.full_messages},status: :unprocessable_entity  

        end
    end

    def sold
        item = Item.find_by(id: params[:id])
        if item
            item.update(sold: true, buyer_id: current_user.id )
            render json: item, status: :ok 
        else
            render json: {error: 'Item no Found'}, status: :unprocessable_entity
        end
    end

    def purchased_items
        buyer = User.find(params[:id])
        if buyer.valid? 

            purchased_items = buyer.purchased_items 
            render json: purchased_items
        else
            render json: {error: 'We could not retrive this information reload the page'} 
        end



    end





    private 

    def item_params
        # strong params to avoid retriving other inf where client is not authorize
        params.permit(:name, :desc, :price)
    end
end
