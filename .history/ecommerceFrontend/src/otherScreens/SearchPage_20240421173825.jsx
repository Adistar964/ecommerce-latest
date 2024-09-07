import HeaderAndFooter from "../HeaderAndFooter";
import { useParams } from "react-router-dom";
import { useContext } from "react";
import { MyContext } from "../configuration/context_config";

function SearchPage() {
    const context = useContext(MyContext);
    const all_products = context["products"]

    const params = useParams();
    const search_text = params["search_text"]

    return (
        <HeaderAndFooter>
        <br /><br /><br />
        Search Page!
        <br /><br /><br />
        </HeaderAndFooter>
    )
}

export default SearchPage;
