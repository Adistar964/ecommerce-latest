
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../../configuration/context_config";

import HeaderAndFooter from "../../HeaderAndFooter";
import { backend_link, displayModal } from "../../App"
import "./cartScreen.css";
import { useNavigate } from "react-router-dom";
import Loading from "../../components/Loading";

// https://source.unsplash.com/1600x900/?products
// ?your search query

export default function CartScreen(){
    const navigate = useNavigate()
    const context = useContext(MyContext)

    const clearCartClick = e => {
        const clearCart = async () => {
            const body = {
                uid:context["user"]["uid"],
                update_query:{$set:{items:[]}}, // emptying the cart
            }
            const requestParams = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(body)
            }
            const response = await fetch(`${backend_link}/updateCart/`, requestParams)
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
                        <h3 style={{fontFamily:"legacy",flexGrow:1}}>
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
                            <img src={item.thumbnail} className="cart-img" />
                            <h5 style={{width:"250px"}}>
                                {item.product_name}
                            </h5>
                            <div className="border p-3 d-flex ml-3 align-items-center justify-content-center">
                            <button onClick={()=>changeQuantity(item,"subtract",context)} 
                                className="btn btn-outline-theme"
                                disabled={item["quantity"]===1}>
                                    -
                                </button>
                                <button className="btn text-dark">
                                    {item.quantity}
                                </button>
                                <button onClick={()=>changeQuantity(item,"add",context)} 
                                className="btn btn-outline-theme">
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
                        <button className="btn btn-outline-success">
                            <i className="bi bi-basket" style={{fontSize:"1.2em"}}>
                                &nbsp;&nbsp;proceed to checkout&nbsp;&nbsp;
                            </i>
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

// the function below deals with updating cart item's quantity
// the setQuantity function is not used except by the productCart component
export const changeQuantity = async (item,operation_type,context, setQuantity=()=>{}) => {
    let cart_items = [...context["cart"]] // we will update our cart by adding quantity
    for (let product of cart_items){
        if(product["product_id"] === item["product_id"]){
            if(operation_type=="add"){
                product["quantity"]++
            }else if(operation_type=="subtract"){
                // if quantity is one, then we must remove that item from the cart itself 
                // as the quantity changes to 0
                if(product["quantity"]!==1){
                    product["quantity"]--;
                }else{
                    const product_index = cart_items.indexOf(product)
                    cart_items.splice(product_index,1) 
                    // this "1" means remove 1 element starting from the specified index
                    setQuantity(0)
                }
            }else if(operation_type=="remove item from cart"){
                // This removes that item from the cart itself

                // displayModal(context, "Remove item from cart?",
                // `Do you wish to remove "${item["product_name"]}" from the cart?`,"Remove",()=>{
                //     const product_index = cart_items.indexOf(product)
                //     cart_items.splice(product_index,1) 
                // })
                const confirm = window.confirm(`"${item["product_name"]}" will be removed from cart?\n Do you want to continue?`)
                if(confirm == true){
                    const product_index = cart_items.indexOf(product)
                    cart_items.splice(product_index,1) 
                }
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
    context["setCart"](()=>cart_items)
}