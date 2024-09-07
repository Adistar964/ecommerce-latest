import HeaderAndFooter from "./HeaderAndFooter";
import { useContext } from "react";
import { MyContext } from "./configuration/context_config";

function SearchPage() {
  const context = useContext(MyContext);
  const products = context["products"]
  return (
    <HeaderAndFooter>
      <br /><br /><br />
      Search Page!
      <ul>
        {products.map(i => <li>{i.title}</li>)}
      </ul>
      <br /><br /><br />
    </HeaderAndFooter>
  )
}

export default SearchPage;
