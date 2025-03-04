
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../../configuration/context_config";

import HeaderAndFooter from "../../HeaderAndFooter";
import { backend_link } from "../../App"
import "./cartScreen.css";

// https://source.unsplash.com/1600x900/?products
// ?your search query

export default function CartScreen(){
    const context = useContext(MyContext)

    const addQuantity = async item => {
        let cart_items = [...context["cart"]] // we will update our cart by adding quantity
        for (let product in cart_items){
            console.log(product)
            if(product["product_id"] === item["product_id"]){
                console.log(product["product_id"])
                product["quantity"] ++;
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
        alert(data["msg"])
    }

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
                            <button className="btn btn-outline-theme">
                                -
                            </button>
                            <p className=" pl-3 pr-3 pt-3">
                                {item.quantity}
                            </p>
                            <button onClick={()=>addQuantity(item)} 
                            className="btn btn-outline-theme">
                                +
                            </button>
                        </div>
                        <div className="ml-3 mr-3">
                            <p>QAR <b>{item.price}</b></p>
                        </div>
                        <div style={{flexGrow:"1"}}
                        className="d-flex justify-content-end">
                            <button style={{borderRadius:"5px"}} 
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
}