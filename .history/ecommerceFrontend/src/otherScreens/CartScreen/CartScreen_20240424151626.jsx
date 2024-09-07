
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../../configuration/context_config";

import HeaderAndFooter from "../../HeaderAndFooter";
import { backend_link } from "../../App"
import "./cartScreen.css";
import { useNavigate } from "react-router-dom";

// https://source.unsplash.com/1600x900/?products
// ?your search query

export default function CartScreen(){
    const navigate = useNavigate()
    const context = useContext(MyContext)

    if(context["cart"].length !== 0){
        return (
            <HeaderAndFooter>
                <div className="p-3 text-center container border border-secondary">
                    <h3 style={{fontFamily:"legacy"}}>
                        YOUR CART
                    </h3>
                    <hr className="bg-danger mb-4" />
                    <ul style={{listStyle:"none"}}>
                        {context["cart"].map(item => 
                        <li className="w-100 border d-flex p-3 align-items-center">
                            <img src={item.thumbnail} className="cart-img" />
                            <h5 className="ml-5">
                                {item.product_name}
                            </h5>
                            <div className="border p-3 d-flex ml-3 align-items-center justify-content-center">
                            <button onClick={()=>changeQuantity(item,"subtract",context)} 
                                className="btn btn-outline-theme"
                                disabled={item["quantity"]===1}>
                                    -
                                </button>
                                <p className=" pl-3 pr-3 pt-3">
                                    {item.quantity}
                                </p>
                                <button onClick={()=>changeQuantity(item,"add",context)} 
                                className="btn btn-outline-theme">
                                    +
                                </button>
                            </div>
                            <div className="ml-3 mr-3">
                                <p>QAR <b>{item.price}</b></p>
                            </div>
                            <div style={{flexGrow:"1"}}
                            className="d-flex justify-content-end">
                                <button onClick={()=>changeQuantity(item,"remove item from cart",context)} 
                                style={{borderRadius:"5px"}} 
                                className="btn btn-danger">
                                    <i className="bi bi-trash"></i>
                                </button>
                            </div>
                        </li>
                        )}
                    </ul>
                </div>
            </HeaderAndFooter>
        );
    }else {
        return(
            <HeaderAndFooter>
                <div className="text-center p-4 container border border-primary">
                    <h3>
                        <i>
                            Your Cart is currently empty!
                        </i>
                    </h3>
                    <h3 style={{fontSize:"10em"}}>
                        <i className="bi bi-bag-dash-fill text-danger"></i>
                    </h3>
                    <button onClick={()=>navigate("/")} 
                    className="mt-3 btn btn-outline-theme">
                        Continue Shopping
                    </button>
                </div>
            </HeaderAndFooter>
        );
    }
}

export const changeQuantity = async (item,operation_type,context) => {
    let cart_items = [...context["cart"]] // we will update our cart by adding quantity
    for (let product of cart_items){
        if(product["product_id"] === item["product_id"]){
            if(operation_type=="add"){
                product["quantity"]++
            }else if(operation_type=="subtract"){
                product["quantity"]--
            }else if(operation_type=="remove item from cart"){
                const product_index = cart_items.indexOf(product)
                cart_items.splice(product_index) 
            }
        }
    }
    const body = {
        uid:context["user"]["uid"],
        update_query:{$set:{items:cart_items}},
    }
    const requestParams = {
        method:"POST",
        headers:{"Content-Type":"application/json"},
        body: JSON.stringify(body)
    }
    const response = await fetch(`${backend_link}/updateCart/`, requestParams)
    const data = await response.json()
    context["setCart"](cart_items)
}