
import { useContext, useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { MyContext } from "../../configuration/context_config";
import "./cartScreen.css";

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
                    <li className="w-100 border d-flex p-3">
                        <img src={item.thumbnail} className="cart-img" />
                        <h3 className="d-flex ml-5 align-items-center">
                            {item.product_name}
                        </h3>
                        <div className="dropdown-show">
                            <button role="button" 
                            id="quantitybtn" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false"
                            className="btn btn-secondary dropdown-toggle">
                                Quantity
                            </button>
                            <div aria-labelledby="quantitybtn" 
                            className="dropdown-menu">
                                <a href="" className="dropdown-item">1</a>
                                <a href="" className="dropdown-item">2</a>
                                <a href="" className="dropdown-item">3</a>
                            </div>
                        </div>
                    </li>
                    )}
                </ul>
            </div>
        </HeaderAndFooter>
    );
}