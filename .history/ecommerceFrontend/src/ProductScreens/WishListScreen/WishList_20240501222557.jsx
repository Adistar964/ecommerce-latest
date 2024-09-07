

import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";

import { currency,backend_link, displayModal } from "../../App";
import { ToggleFavourites } from "./WishListFunction";

import { useContext, useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { MyContext } from "../../configuration/context_config";
import { toast } from "react-toastify";

// importing icons
import {BsBagDashFill,BsTrash,BsFillBagHeartFill } from "react-icons/bs";
import { FaShoppingBag } from "react-icons/fa";

export default function WishList(props){

    const [emptyWishList,setEmptyWishList] = useState(true)
    const [loading, setLoading] = useState(true)
    
    const context = useContext(MyContext)
    const navigate = useNavigate() 

    // fetching all user's favourites
    useEffect(() => {
        setLoading(true)
        // our user must be signed-in and must have somehting in the wishlist
        // otherwise the empty-wish-list component will be rendered 
        if(context["user"]!==null && context["favourites"].length!==0){
            setEmptyWishList(false)
        }else {
            setEmptyWishList(true)
        }
        setLoading(false)
    },[context["favourites"]])

    // this will basically turn that selected item's color to aliceclue to visually show that it is selected
    const showSelected = (e,idx)=>{
        if(e.target.checked){
            document.getElementById("wishlist-"+idx).style.backgroundColor="aliceblue" // shows selection
        }else if(!e.target.checked){
            document.getElementById("wishlist-"+idx).style.backgroundColor="white" // back to normal
        }
    }

    // this will add selected items to cart with their quantities:

    const addSelectedToCart = async () =>  {
        let selected_items = []
        // first we will get all selected items and then add them to the list with their quantities
        let idx = 0; // this will be for accessing the item's index while iterating
        for(let item of context["favourites"]){
            if(document.getElementById("wishlist-check-"+String(idx)).checked){
                const item_quantity = document.getElementById("wishlist-select-"+String(idx)).value // will give us selected quantity
                selected_items.push({product:item,quantity:Number(item_quantity)})
            }
            idx++; // for next iteration
        }

        // now we will make sure that the user has atleast selected something
        if(selected_items.length !== 0){
            // Now we will add the items to our cart based on the current cart the user has
            // setLoading(true)

            let user_cart = [...context["cart"]]
            for(let wishlist_item of selected_items){
                
                let exists_in_cart = false; // to check if it is already in cart

                for(let cart_item of user_cart){
                    // if it exists in our cart already, then we will just increase its quantity
                    if(cart_item.product_id === wishlist_item["product"].product_id){
                        exists_in_cart = true;
                        cart_item.quantity = cart_item.quantity + wishlist_item["quantity"]
                    }
                }
                // if it isnt in cart, then we will add it in cart
                if(!exists_in_cart){
                    const product = {...wishlist_item["product"],quantity:wishlist_item["quantity"]} // in the right document format
                    user_cart.push(product)
                }
            }

            // now we will set our user's cart to this modified "user_cart" by requesting the backend
            const body = {
                uid:context["user"]["uid"],
                update_query:{$set:{cart_items:user_cart}} // mongodb query
            }
            const request_params = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body:JSON.stringify(body)
            }
            const response = await fetch(`${backend_link}/updateUserDoc/`,request_params)
            const json_response = await response.json()
            context.setCart(user_cart) // for state upate within the application
            toast.success("your selections were added to the cart!")
            setLoading(false)
        }else{
            toast.error("Please make selections before adding to cart!")
        }
    }

    // the below will clear user's wishlist
    const clearWishListClick = e => {
        const clearFavs = async () => {
            const body = {
                uid:context["user"]["uid"],
                update_query:{$set:{user_favourites:[]}}, // emptying the cart
            }
            const requestParams = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(body)
            }
            const response = await fetch(`${backend_link}/updateUserDoc/`, requestParams)
            const data = await response.json()
            context.setFavourites([]) // for real-time state update in our app
        }
        e.preventDefault() // so it doesnt refresh the page
        displayModal(context, "Clear Cart",
        "Do you want to proceed clearing your wishlist? \n\n Note: The process cannot be undone",
    "Yes", clearFavs)
    }

    if(loading){
        return <Loading />
    }else{
        if(emptyWishList){ // if wish-list not there(empty)
            return(
                <HeaderAndFooter>
                <div className="text-center p-4 container border border-primary">
                    <h3>
                        <i>
                            Your WishList is empty!
                        </i>
                    </h3>
                    <BsFillBagHeartFill size="10em" className="d-block text-info m-auto mt-4 mb-4" />
                    <p className="border p-2">
                        <u>
                            <h5><i>Note:</i></h5>
                        </u>
                        For adding a product to your wish list, navigate to 
                        that product's page and click "Add to Wish List" 
                    </p>
                    <button onClick={()=>navigate("/")} 
                    className="mt-3 btn btn-outline-theme">
                        Continue Shopping
                    </button>
                </div>
            </HeaderAndFooter>
            );
        }else if(!emptyWishList){ // if wish-list available(not empty)
            return(
                <HeaderAndFooter>
                    <div className="p-3 text-center container border border-secondary">
                        <div className="d-flex">
                            <h3 style={{fontFamily:"san-serif",flexGrow:1}}>
                                WISH-LIST
                            </h3>
                            <a href="" 
                            onClick={clearWishListClick}
                            style={{display:"inline",cursor:"pointer"}}>
                                Clear WishList
                            </a>
                        </div>
                        <hr className="bg-danger mb-4" />
                        <ul style={{listStyle:"none"}}>
                            {context["favourites"].map((item,idx) => 
                            <li key={idx} id={"wishlist-"+idx}
                            style={{justifyContent:"space-between",
                             cursor:"pointer",transition:"all 0.5s",}} 
                            className="w-100 border d-flex p-3 align-items-center cart-item-hover">
                                <input id={"wishlist-check-"+idx} 
                                style={{transform:"scale(1.5)"}}  // basically increasing its size
                                onClick={e=>showSelected(e,idx)}
                                type="checkbox" />
                                <img onClick={()=>navigate("/product/"+item.product_id)} 
                                src={item.thumbnail} className="cart-img"
                                style={{cursor:"pointer"}} />
                                <h5 onClick={()=>navigate("/product/"+item.product_id)} 
                                style={{width:"250px",cursor:"pointer"}}>
                                    {item.product_name}
                                </h5>
                                <div className="p-3 ml-3">
                                    <label className="form-label" htmlFor={"wishlist-select-"+idx}>
                                        Quantity
                                    </label>
                                    <select onChange={e=>{
                                        const target = e.target;
                                        const price = document.getElementById("wish-price"+idx).textContent
                                        document.getElementById("wish-price"+idx).textContent = Number(price) * Number(target.value)
                                    }} 
                                    id={"wishlist-select-"+idx} className="form-select">
                                        {/* the below is basically like range() from python */}
                                        {/* ex: Array(4) => o/p: [0,1,2,3] like range(4) */}
                                        {[...Array(item.maxQuantityForAUser).keys()].map(elem => 
                                            <option value={elem+1}>{elem+1}</option>
                                            // we dont want to start from "0"
                                        )}
                                    </select>
                                </div>
                                <div className="ml-3 mr-3">
                                    <p>QAR 
                                        <b id={"wish-price"+idx}>
                                            {/* if there is discount, it will be deducted from the actual price */}
                                            {(item.price-item.discountPrice)}
                                        </b>
                                    </p>
                                </div>
                                <div className="d-flex justify-content-end">
                                    <button 
                                    onClick={()=>
                                    displayModal(context,"Remove from wishlist",
                                    "Do you want to proceed removing '"+item["product_name"]+"' from the wishlist?",
                                    "remove",
                                    ()=>{
                                        ToggleFavourites(context,item);toast.success("item removed from wishlist")
                                    })
                                        } 
                                    style={{borderRadius:"5px"}} 
                                    className="btn btn-danger">
                                        <BsTrash size="1.2em" />
                                    </button>
                                </div>
                            </li>
                            )}
                        </ul>
                        <hr />
                        <div className="text-center">
                            <button onClick={addSelectedToCart} 
                            style={{fontSize:"1.2em"}}
                            className="btn btn-outline-success" id="addFavToCart">
                                    <FaShoppingBag size="1.2em" className="mb-1" />
                                    &nbsp;&nbsp;Add to Cart&nbsp;&nbsp;
                            </button>
                        </div>
                    </div>
                </HeaderAndFooter>
            );
        }
    }

}