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
      <button onClick={()=>console.log(products)}
       className="btn btn-info">
        click
      </button>
      <br /><br /><br />
    </HeaderAndFooter>
  )
}

export default Home;
