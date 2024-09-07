
import { backend_link } from "../../App";




// this function will help us add/remove a item from wishlist/favourites 

export async function ToggleFavourites(context,product){
        let favourites = [...context["favourites"]]
        let exists = false; // we will first see if that item is already on wishlist
        // if it is there, then we will remove it
        // otherwise we will add it
        for (let item of favourites){
            if (item["product_id"] === product.product_id){
                exists = true; // as it exists, we will remove it
                const idxItem = favourites.indexOf(item)
                favourites.splice(idxItem,1) 
                // "1" means remove 1 item starting from that specified index
            }
        }
        if (exists === false){
            // if it doesnt exists
            // we will add it to user's favourites/wish-list
            favourites.push({
                product_id:product.product_id,
                thumbnail:product.thumbnail,
                price:product.price,
                product_name:product.title,
            })
        }
        const body = {
            update_query:{$set:{user_favourites:favourites}}, // mongodb update query
            uid: context["user"]["uid"]
        }
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        const response = await fetch(`${backend_link}/updateUserDoc/`,requestParams);
        const data = await response.json()
        console.log(favourites)
        context.setFavourites(favourites) // for real-time updates
    }