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
    <h3 className="text-center text-srch">
        Home:
    </h3>
    <Carousel>
      <Carousel.Item>
        first slide
      </Carousel.Item>
      <Carousel.Item>
        Second slide
      </Carousel.Item>
    </Carousel>
</HeaderAndFooter>
  )
}

export default Home;
