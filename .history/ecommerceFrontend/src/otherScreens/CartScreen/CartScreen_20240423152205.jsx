
import { useContext, useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { MyContext } from "../../configuration/context_config";
import "./cartScreen.css";

// https://source.unsplash.com/1600x900/?products
// ?your search query

export default function CartScreen(){
    const context = useContext(MyContext)
    return (
        <HeaderAndFooter>
            <div className="p-3 text-center container border border-secondary">
                <h3 style={{fontFamily:"legacy"}}>
                    YOUR CART
                </h3>
                <hr className="bg-danger mb-4" />
                <ul style={{listStyle:"none"}}>
                    {context["cart"].map(item => 
                    <li className="w-100 border d-flex p-3 justify-content-center">
                        <img src={item.thumbnail} className="cart-img" />
                        <h5 className="d-flex ml-5 align-items-center">
                            {item.product_name}
                        </h5>
                        <div className="d-flex">
                            add to cart
                        </div>
                    </li>
                    )}
                </ul>
            </div>
        </HeaderAndFooter>
    );
}