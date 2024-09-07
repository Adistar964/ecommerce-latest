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
        <Carousel.Caption>
          First Slide
        </Carousel.Caption>
      </Carousel.Item>
      <Carousel.Item>
        <img className="w-100"
         src="https://api.safarihypermarket.com/website/image/banner.element.item/2570/image" />
        <Carousel.Caption>
          Second Slide
        </Carousel.Caption>
      </Carousel.Item>
      <Carousel.Item>
        <img className="w-100"
         src="https://api.safarihypermarket.com/website/image/banner.element.item/2571/image" />
        <Carousel.Caption>
          Second Slide
        </Carousel.Caption>
      </Carousel.Item>
    </Carousel>
</HeaderAndFooter>
  )
}

export default Home;
