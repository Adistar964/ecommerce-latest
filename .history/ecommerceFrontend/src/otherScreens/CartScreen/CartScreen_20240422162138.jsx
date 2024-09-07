
import { useContext, useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { MyContext } from "../../configuration/context_config";

export default function CartScreen(){
    const context = useContext(MyContext)
    const [cart,setCart] = useState([...context["cart"]])
    // our cart-items have only the product id,
    //  therefore we must also add other properties to it like images,title,etc..
    useEffect(() => {
        const products = context["products"]
        const detailedCart = [...cart]
        for (let product in products){
            for (let cart_item in detailedCart){
                if(cart_item["product_id"] === product["_id"]){
                    cart_item = {...cart_item, ...product} 
                    // will get all the properties like images, title, etc..
                }
            }
        }
    },[]) // will run once the component is loaded
    return (
        <HeaderAndFooter>
            <div className="p-3 text-center container border border-secondary">
                <h3 style={{fontFamily:"legacy"}}>
                    YOUR CART
                </h3>
                <hr className="bg-danger mb-4" />
                <ul style={{listStyle:"none"}}>
                    {cart.map(item => 
                    <li className="w-100 border d-flex">
                        <img src="" alt="" />
                    </li>
                    )}
                </ul>
            </div>
        </HeaderAndFooter>
    );
}