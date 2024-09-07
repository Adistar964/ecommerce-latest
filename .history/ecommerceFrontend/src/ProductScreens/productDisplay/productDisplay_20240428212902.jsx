import { useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";
import Loading from "../../components/Loading"
import { backend_link } from "../../App"

export default function ProductDisplay(props){
    const params = useParams()

    const [product, setProduct] = useState("");
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const getProduct = async () => {
            const body = {
                _id:params["pid"]
            }
            const requestParams = {
                method:"POST",
                "headers":{"Content-Type":"application/json"},
                body:JSON.stringify(body)
            }
            fetch(`${backend_link}/getproducts/`,requestParams)
            .then(res => res.json())
            .then(data => console.log(data))
            .catch(err => {console.log(err);alert("error!")})
        }

        getProduct()
        
    }, [params])

    if(loading){
        return <Loading />
    }
    return(
        <HeaderAndFooter>
            Product Screen
        </HeaderAndFooter>
    );
}