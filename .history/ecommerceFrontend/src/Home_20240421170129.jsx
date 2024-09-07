import HeaderAndFooter from "./HeaderAndFooter";
import { useContext } from "react";
import { MyContext } from "./configuration/context_config";
import { linkWithCredential } from "firebase/auth";

function Home() {
  const context = useContext(MyContext);
  const products = context["products"]
  return (
    <HeaderAndFooter>
      <br /><br /><br />
      Home Page!
      <ul>
        {products.map(i => <li>{i.title}</li>)}
      </ul>
      <br /><br /><br />
    </HeaderAndFooter>
  )
}

export default Home;
