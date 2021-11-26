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
    # 2 render one specific item 
    def show
        
        item = Item.find_by(id: params[:id])
        if item 
            render json: item 
        else
            render json: {error: error.full_messages}, status_code: :not_found  
        
        end

    end


    # 3. current user is creating items using sold_items association check user model to confirm
    def create  
        
        item = current_user.sold_items.create(item_params)
        if item.valid?
            render json: item, status: :created 
        else
            render json: {error: item.errors.full_messages},status: :unprocessable_entity  

        end
    end
    # 4. update the item  

    def update
        item = Item.find_by(:id: params[:id])
        if item && item.update(item_params)
            render json: item, status: :ok
        else
            render json: {error: item.errors.full_messages}, status: :unprocessable_entity  
        end

    end


    # 5. deletes the item from the database 


    def destroy
        
        item = Item.find_by(id: params[:id])
        if item.valid? 
            item.destroy 
            head :not_content 
        else
            render json: {error: 'Item no found'}, status: :unprocessable_entity  
        end

    end

        
    # 6. update avaibility of the item to sold
        def sold
            item = Item.find_by(id: params[:id])
            if item
                item.update(sold: true, buyer_id: current_user.id )
                render json: item, status: :ok 
            else
                render json: {error: 'Item no Found'}, status: :unprocessable_entity
            end
        end

    # 7 
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
