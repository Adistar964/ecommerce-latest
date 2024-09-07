
import { useContext, useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { MyContext } from "../../configuration/context_config";

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
                    <li className="w-100 border d-flex">
                        <img src={item.thumbnail} className="cart-img" />
                    </li>
                    )}
                </ul>
            </div>
        </HeaderAndFooter>
    );
}