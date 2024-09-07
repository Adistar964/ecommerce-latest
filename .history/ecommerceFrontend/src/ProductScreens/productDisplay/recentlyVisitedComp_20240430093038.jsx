import { useEffect, useState } from "react";


export default function RecentlyVisitedItems(){

    const [products,setProducts] = useState([])
    
    useEffect(() => {
        const getProducts = () => {
            const prodsFromLocalStorage = localStorage.getItem("recentlyVisited")
            setProducts(JSON.parse(prodsFromLocalStorage))
        }

        getProducts()

    }, localStorage)

    if(products.length !== 0){ // only render it when u have recently visited products!
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