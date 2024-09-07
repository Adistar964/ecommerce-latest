import { useEffect, useState } from "react";


export default function RecentlyVisitedItems(){

    const [products,setProducts] = useState([])
    
    useEffect(() => {
        const getProducts = () => {
            
        }

        getProducts()

    }, localStorage)

    if(products.length !== 0){
        return(
            <div className="border container mt-4">
                <h3 className="sideBarText">
                    Recently Visited
                    <hr className="border border-primary" />
                </h3>
            </div>
        );
    }
}