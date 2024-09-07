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
        <img style={{width:"100%",height:"200px"}}
         src="https://picsum.photos/200" />
        <Carousel.Caption>
          First Slide
        </Carousel.Caption>
      </Carousel.Item>
      <Carousel.Item>
        <img style={{width:"100%",height:"200px"}}
         src="https://picsum.photos/1000/200" />
        <Carousel.Caption>
          Second Slide
        </Carousel.Caption>
      </Carousel.Item>
    </Carousel>
</HeaderAndFooter>
  )
}

export default Home;
