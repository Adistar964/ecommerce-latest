

import { useContext } from "react";
import { MyContext } from "../configuration/context_config";

export default function Test(){
    const {cart} = useContext(MyContext)
    return(
        <div className="text-center">
            {cart.map(i => 
                <li>{i["product_id"]}</li>
            )}
        </div>
    );
}