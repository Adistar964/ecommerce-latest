import { useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";
import Loading from "../../components/Loading"
import { backend_link } from "../../App"
import Error from "../../otherScreens/Error/Error";

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
                    setNotFound(true) // as data is not there
                    setLoading(false)
                }
            })
            .catch(err => {
                // if we have some error,
                // we will still show 404 page!
                console.log(err);
                setNotFound(true)
                setLoading(false)
            })
        }
        getProduct()
        
    }, [params])

    if(loading){
        return <Loading />
    }
    else if(!loading){
        if(notFound){
            return <Error /> // we will give them a 404 error
        }else{
            return(
                <HeaderAndFooter>
                    Product Screen
                </HeaderAndFooter>
            );
        }
    }
}