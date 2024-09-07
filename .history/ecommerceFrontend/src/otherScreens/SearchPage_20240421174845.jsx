import HeaderAndFooter from "../HeaderAndFooter";
import { useParams } from "react-router-dom";
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../configuration/context_config";
import { backend_link } from "../App"

function SearchPage() {
    const context = useContext(MyContext);
    const all_products = context["products"]

    const params = useParams();
    const search_text = params["search_text"]

    const [srchResults,setSrchResults] = useState([]);

    useEffect(()=>{
        const getProducts = async () => {
            // const response = await fetch()
        }
    }, [])

    return (
        <HeaderAndFooter>
        <br /><br /><br />
        Search Page!
        <br /><br /><br />
        </HeaderAndFooter>
    )
}

export default SearchPage;
