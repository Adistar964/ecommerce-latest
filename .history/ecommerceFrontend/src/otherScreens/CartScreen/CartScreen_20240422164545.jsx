
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
                        <div class="dropdown show">
  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Dropdown link
  </a>

  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <a class="dropdown-item" href="#">Action</a>
    <a class="dropdown-item" href="#">Another action</a>
    <a class="dropdown-item" href="#">Something else here</a>
  </div>
</div>
                    </li>
                    )}
                </ul>
            </div>
        </HeaderAndFooter>
    );
}