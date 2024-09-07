import ProductCard from "../../components/ProductCard";

import { useEffect, useState } from "react";

export default function RecentlyVisitedItems(){

    const [products,setProducts] = useState([])
    
    useEffect(() => {
        const getProducts = () => {
            // we r getting recently-visited prods from localStorage and then showing it!
            let prodsFromLocalStorage = localStorage.getItem("recentlyVisited")
            prodsFromLocalStorage = JSON.parse(prodsFromLocalStorage) // convert it from string to js-array
            setProducts(prodsFromLocalStorage.reverse());
            // reason for .reverse() :
            // The last product is the most recent visited product,
            //  therefore we dont want it to be in last, but in firt position

        }

        getProducts()

    }, localStorage)

    return(
        <div className="border container mt-4">
            <h3 className="sideBarText">
                Recently Visited
                <hr className="border border-primary" />
            </h3>
            <div className="cards-container p-3">
                {products.map(prod => 
                    <ProductCard thumbnail={prod.thumbnail}
                    title={prod.title}
                    price={prod.price}
                    discountPrice={prod.discountPrice}
                    product_id={prod._id}
                     />
                )}
            </div>
        </div>
    );
}