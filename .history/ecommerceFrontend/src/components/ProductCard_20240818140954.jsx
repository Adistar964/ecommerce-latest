
import { currency, checkLoggedIn } from "../App"
import { MyContext } from "../configuration/context_config";
import { useContext, useState, useEffect } from "react";
import { changeQuantity, addToCart } from "../ProductScreens/CartScreen/CartFunctions.jsx";

// importing bootstrap
// but first do "npm install react-bootstrap"
import { useNavigate } from "react-router-dom";

// importing react-icons

export default function ProductCard(props){
    const context = useContext(MyContext)
    const cart = context["cart"]
    const setCart = context["setCart"]
    const [quantity_in_cart,setQuantity] = useState(0)
    const navigate = useNavigate();

    useEffect(() => {
        const items = [...cart]
        let exists_in_cart = false;
        for(let cart_item of items){
            if(props.product_id === cart_item.product_id){
                exists_in_cart = true
                setQuantity(cart_item.quantity)
            }
        }
        if(!exists_in_cart){
            setQuantity(0)
        }
    }, [cart]) // we will run this everytime the user's cart changes
    return (
    <div className="product-card">
            <img onClick={()=>{
                window.location.href = "/product/"+props.product_id
                // we r bascially navigating to another page by causing a refresh
                window.scrollTo(0,0); // scroll to the top before navigating just in case
            }} 
            src={props.thumbnail} alt="product image" />
            <div style={{paddingLeft:"10px"}}>
                <p style={{cursor:"pointer"}} onClick={()=>{
                    window.location.href = "/product/"+props.product_id
                    window.scrollTo(0,0);
                    }}>
                    {props.title}
                </p>
                <br />
                    {props.discountPrice!==0 ?
                    <small>
                        <del>
                               {/* .toFixed(2) => 2 decimal places */}
                               {currency} {(props.price+props.discountPrice).toFixed(2)}
                            <br />
                        </del>
                    </small>
                    : ""
                }
                <i>
                    {currency} <b>{props.price}</b>
                </i> 
            </div><br />
            {quantity_in_cart === 0 ? 
                <button
                onClick={()=>checkLoggedIn(context,()=>addToCart(context,props))} // props have all our item's properties
                style={{alignSelf:"flex-end"}} 
                className="btn btn-theme w-100">
                    Add
                </button> : 
            <div className="btn-group">
                <button onClick={()=>changeQuantity(props, "subtract",context,setQuantity)} 
                className="btn btn-theme">
                    -
                </button>
                <button className="btn border-top border-bottom text-dark">
                    {quantity_in_cart}
                </button>
                <button onClick={()=>changeQuantity(props, "add",context)} 
                className="btn btn-primary"
                // we will not allow the user to add more quantity than the maxQuantityForAUser by disabling this button once the user reaches that limit  
                disabled={props.maxQuantityForAUser === quantity_in_cart}>
                    +
                </button>
            </div>
        }
        </div>
    );
}