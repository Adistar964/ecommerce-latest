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
            const query = {
                title:{
                    $in:[search_text.split("")]
                }
            }
            const requestParams = {
                method:"POST",
                headers: {"Content-Type":"application/json"},
                body:JSON.stringify(query)
            }
            const response = await fetch(`${backend_link}/getproducts/`,requestParams)
            const data = await response.json()
            setSrchResults(data)
            console.log(data)
        }
        const getProducts2 = () => {
            const filtered = []
            for (let i of all_products){
                if(i["title"].includes(search_text)){
                    filtered.push(i)
                }
            }
            setSrchResults(filtered)
        }
    getProducts2()
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
