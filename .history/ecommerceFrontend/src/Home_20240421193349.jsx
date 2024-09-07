import HeaderAndFooter from "./HeaderAndFooter";
import { useContext } from "react";
import { MyContext } from "./configuration/context_config";
import { currency } from "./App";

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
            <div className="product-card">
                <img src={prod.thumbnail} alt="product image" />
                <div style={{paddingLeft:"10px"}}>
                    <p>
                        {prod.title}
                    </p>
                    <br />
                        {prod["discountPercentage"] ?
                        <small>
                        <del>{currency} {prod["price"]+prod["discountPercentage"]} <br /></del>
                        </small>
                        : ""
                    }
                    <i>
                        {currency} <b>{prod["price"]}</b>
                    </i> 
                </div><br />
                <button style={{alignSelf:"flex-end"}} 
                className="btn btn-theme w-100">
                    Add
                </button>
            </div>
        )}
    </div>
</HeaderAndFooter>
  )
}

export default Home;
