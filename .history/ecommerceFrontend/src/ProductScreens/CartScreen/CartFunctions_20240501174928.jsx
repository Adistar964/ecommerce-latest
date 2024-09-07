
import { backend_link } from "../../App";



    // first time adding smth to cart
    // this will add that item to user's cart
    // and once added, now changeQuantity function will take care of rest

export async function addToCart(context,product){
        const items = [...context["cart"]]
        // let exists = false;
        // for (let item of items){
        //     if (item["product_id"] === product.product_id){
        //         exists = true;
        //         item["quantity"] ++;
        //     }
        // }
        // if (exists === false){
            items.push({
                product_id:product.product_id,
                quantity:1,
                thumbnail:product.thumbnail,
                price:product.price,
                product_name:product.title,
                maxQuantityForAUser:product.maxQuantityForAUser
            })
        // }
        console.log("items are",items)
        const body = {
            update_query:{$set:{cart_items:items}},
            uid: context["user"]["uid"]
        }
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        const response = await fetch(`${backend_link}/updateUserDoc/`,requestParams);
        const data = await response.json()
        context.setCart(items)
    }
    

// the function below deals with updating cart item's quantity
// the setQuantity function is optional => only for setting live real-time quantity => ex:showing live quantity of that product
export const changeQuantity = async (targetItem,operation_type,context, setQuantity=()=>{}) => {
    let cart_items = [...context["cart"]] // we will update our cart by adding quantity
    for (let product of cart_items){
        if(product["product_id"] === targetItem["product_id"]){ // we will find the targetItem in our cart_items
            // and then apply operations for that specific item
            if(operation_type=="add"){
                // now we will make sure that the user doesnt exceed maxLimit for adding that item in the cart
                product["quantity"]++
            }else if(operation_type=="subtract"){
                // if quantity is one, then we must remove that item from the cart itself 
                // as the quantity changes to 0
                if(product["quantity"]!==1){
                    product["quantity"]--;
                }else if(product["quantity"] === 1){
                    const product_index = cart_items.indexOf(product)
                    cart_items.splice(product_index,1) 
                    // this "1" means remove 1 element starting from the specified index
                    setQuantity(0) // callback setState for live-chnages(dont confuse)
                }
            }else if(operation_type=="remove item from cart"){
                // This removes that item from the cart itself

                // displayModal(context, "Remove item from cart?",
                // `Do you wish to remove "${item["product_name"]}" from the cart?`,"Remove",()=>{
                //     const product_index = cart_items.indexOf(product)
                //     cart_items.splice(product_index,1) 
                // })
                const confirm = window.confirm(`"${targetItem["product_name"]}" will be removed from cart?\n Do you want to continue?`)
                if(confirm == true){
                    const product_index = cart_items.indexOf(product)
                    cart_items.splice(product_index,1) 
                }
            }
        }
    }
    const body = {
        uid:context["user"]["uid"],
        update_query:{$set:{cart_items:cart_items}}, // replacing the cart_items array with our modified array
    }
    const requestParams = {
        method:"POST",
        headers:{"Content-Type":"application/json"},
        body: JSON.stringify(body)
    }
    const response = await fetch(`${backend_link}/updateUserDoc/`, requestParams)
    const data = await response.json() // we dont need this anyways
    context["setCart"](()=>cart_items)
}