import HeaderAndFooter from "../HeaderAndFooter";
import { useParams } from "react-router-dom";
import { useContext } from "react";
import { MyContext } from "../configuration/context_config";

function SearchPage() {
    const context = useContext(MyContext);
    const products = context["products"]

    const params = useParams();
    console.log(params)

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
