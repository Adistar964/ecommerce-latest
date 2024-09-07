import HeaderAndFooter from "./HeaderAndFooter";
import { useContext } from "react";
import { MyContext } from "./configuration/context_config";
import { currency } from "./App";
import ProductCard from "./components/ProductCard";

function Home() {
  const context = useContext(MyContext);
  const products = context["products"]
  return (
    <HeaderAndFooter>
    <h3 className="text-center text-srch">
        Home:
    </h3>
    <div className="cards-container ml-4 mr-4">
        {products.map(prod => 
                    <ProductCard product_id={prod["_id"]} 
                    price={prod["price"]} 
                    title={prod["title"]} 
                    discountPrice={prod["discountPercentage"]}
                    thumbnail={prod["thumbnail"]} />
                    )}
    </div>
</HeaderAndFooter>
  )
}

export default Home;
