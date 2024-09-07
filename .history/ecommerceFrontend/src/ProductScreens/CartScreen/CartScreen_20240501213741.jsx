
import { useContext } from "react";
import { MyContext } from "../../configuration/context_config";

import HeaderAndFooter from "../../HeaderAndFooter";
import { backend_link, displayModal } from "../../App"
import "./cartScreen.css";
import { useNavigate } from "react-router-dom";
import Loading from "../../components/Loading";
import { toast } from "react-toastify";

import { changeQuantity } from "./CartFunctions";

// importing icons
import { BsBagDashFill,BsBasket } from "react-icons/bs";

// https://source.unsplash.com/1600x900/?search_query


export default function CartScreen(){
    const navigate = useNavigate()
    const context = useContext(MyContext)

    const clearCartClick = e => {
        const clearCart = async () => {
            const body = {
                uid:context["user"]["uid"],
                update_query:{$set:{cart_items:[]}}, // emptying the cart
            }
            const requestParams = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(body)
            }
            const response = await fetch(`${backend_link}/updateUserDoc/`, requestParams)
            const data = await response.json()
            context.setCart([])
        }
        e.preventDefault() // so it doesnt refresh the page
        displayModal(context, "Clear Cart","Do you want to proceed clearing the cart?",
    "Yes", clearCart)
    }

    if(context["loading"]){
        return <Loading />
    }
    else if(context["cart"].length !== 0){
        return (
            <HeaderAndFooter>
                <div className="p-3 text-center container border border-secondary">
                    <div className="d-flex">
                        <h3 style={{fontFamily:"san-serif",flexGrow:1}}>
                            YOUR CART
                        </h3>
                        <a href="" 
                        onClick={clearCartClick}
                        style={{display:"inline",cursor:"pointer"}}>
                            Clear cart
                        </a>
                    </div>
                    <hr className="bg-danger mb-4" />
                    <ul style={{listStyle:"none"}}>
                        {context["cart"].map(item => 
                        <li style={{justifyContent:"space-between", cursor:"pointer",transition:"all 0.5s"}} 
                        className="w-100 border d-flex p-3 align-items-center cart-item-hover">
                            <img onClick={()=>navigate("/product/"+item.product_id)} 
                            src={item.thumbnail} className="cart-img"
                            style={{cursor:"pointer"}} />
                            <h5 onClick={()=>navigate("/product/"+item.product_id)} 
                            style={{width:"250px",cursor:"pointer"}}>
                                {item.product_name}
                            </h5>
                            <div className="border p-3 d-flex ml-3 align-items-center justify-content-center">
                            <button onClick={()=>changeQuantity(item,"subtract",context)} 
                                className="btn btn-outline-primary"
                                disabled={item["quantity"]===1}>
                                    -
                                </button>
                                <button className="btn text-dark">
                                    {item.quantity}
                                </button>
                                <button onClick={()=>changeQuantity(item,"add",context)} 
                                className="btn btn-outline-primary"
                                // we will not allow the user to add more quantity than the maxQuantityForAUser by disabling this button once the user reaches that limit  
                                disabled={item.maxQuantityForAUser === item.quantity}> 
                                    +
                                </button>
                            </div>
                            <div className="ml-3 mr-3">
                                <p>QAR <b>{item.price}</b></p>
                            </div>
                            <div className="d-flex justify-content-end">
                                <button onClick={()=>changeQuantity(item,"remove item from cart",context)} 
                                style={{borderRadius:"5px"}} 
                                className="btn btn-danger">
                                    <i className="bi bi-trash"></i>
                                </button>
                            </div>
                        </li>
                        )}
                    </ul>
                    <hr />
                    <div className="text-center">
                        <button onClick={() => navigate("/order")} 
                        className="btn btn-outline-success">
                                <BsBasket size="1.3em" />
                                &nbsp;&nbsp;proceed to checkout&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
            </HeaderAndFooter>
        );
    }else if(context["cart"].length === 0 && context["loading"]===false){
        return(
            <HeaderAndFooter>
                <div className="text-center p-4 container border border-primary">
                    <h3>
                        <i>
                            Your Cart is currently empty!
                        </i>
                    </h3>
                    <BsBagDashFill  color="rgb(245, 55, 55)" size="10em" className="d-block m-auto mt-4 mb-4" />
                    <button onClick={()=>navigate("/")} 
                    className="mt-3 btn btn-outline-theme">
                        Continue Shopping
                    </button>
                </div>
            </HeaderAndFooter>
        );
    }
}

