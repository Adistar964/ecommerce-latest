import HeaderAndFooter from "./HeaderAndFooter";
import { useContext } from "react";
import { MyContext } from "./configuration/context_config";
import { currency } from "./App";
import ProductCard from "./components/ProductCard";

// importing from rect-bootstrap
import { Carousel } from "react-bootstrap";

function Home() {
  const context = useContext(MyContext);
  const products = context["products"]
  return (
    <HeaderAndFooter>
    <Carousel>
      <Carousel.Item>
        <img className="w-100"
         src="https://api.safarihypermarket.com/website/image/banner.element.item/2569/image" />        
      </Carousel.Item>
      <Carousel.Item>
        <img className="w-100"
         src="https://api.safarihypermarket.com/website/image/banner.element.item/2570/image" />        
      </Carousel.Item>
      <Carousel.Item>
        <img className="w-100"
         src="https://api.safarihypermarket.com/website/image/banner.element.item/2585/image" />        
      </Carousel.Item>
    </Carousel>
    <img 
    src="https://api.safarihypermarket.com/website/image/banner.element.item/1242/image"
     alt="" />
</HeaderAndFooter>
  )
}

export default Home;
