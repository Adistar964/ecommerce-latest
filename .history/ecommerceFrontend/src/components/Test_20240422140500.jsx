

import { useContext } from "react";
import { MyContext } from "../configuration/context_config";

export default function Test(){
    const context = useContext(MyContext)
    const cart = context["cart"]
    return(
        <div className="text-center">
            {cart.map(i => 
                <li>{i["product_id"]}</li>
            )}
        </div>
    );
}