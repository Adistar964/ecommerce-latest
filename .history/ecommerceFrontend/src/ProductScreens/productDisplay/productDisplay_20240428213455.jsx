import { useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";
import Loading from "../../components/Loading"
import { backend_link } from "../../App"

export default function ProductDisplay(props){
    const params = useParams()

    const [product, setProduct] = useState("");
    const [loading, setLoading] = useState(true);
    const [notFound, setNotFound] = useState(false);

    useEffect(() => {
        setLoading(true) // just incase it is not loading
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
            .then(data => {
                if(data.length === 0){
                    const e = new Error("Response not found");
                    e.code = "ENOENT";  // Triggers a 404
                    throw e;
                }
            })
            .catch(err => {
                console.log(err);
                setNotFound(true) // as data is not there
                setLoading(false)
            })
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