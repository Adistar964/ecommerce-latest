

import { useContext, useEffect, useState } from "react";
import { MyContext, useMyContext } from "../configuration/context_config";

export default function Test(){
    let {cart} = useMyContext()
    let [cartt,setCartt] = useState(cart)
    useEffect(()=>{
        setCartt(cart)
    })
    return(
        <div className="text-center">
            <ol>
                {cartt.map(i =>
                    <li>{i["product_id"]}</li>
                )}
            </ol>
        </div>
    );
}