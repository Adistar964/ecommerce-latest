
import { backend_link } from "../../App";



    // first time adding smth to cart
    // this will add that item to user's cart
    // and once added, now changeQuantity function will take care of rest

    export async function addToCart(context,product){
        const items = [...context["cart"]]
        let exists = false;
        for (let item of items){
            if (item["product_id"] === product.product_id){
                exists = true;
                item["quantity"] ++;
            }
        }
        if (exists === false){
            items.push({
                product_id:product.product_id,
                quantity:1,
                thumbnail:product.thumbnail,
                price:product.price,
                product_name:product.title,
            })
        }
        const body = {
            update_query:{$set:{items:items}},
            uid: context["user"]["uid"]
        }
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        const response = await fetch(`${backend_link}/updateCart/`,requestParams);
        const data = await response.json()
        context.setCart(items)
    }
    