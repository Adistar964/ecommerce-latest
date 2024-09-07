import { useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";
import Loading from "../../components/Loading"

export default function ProductDisplay(props){
    const params = useParams()
    
    const [product, setProduct] = useState("");
    const [loading, setLoading] = useState(true);

    if(loading){
        return <Loading />
    }
    return(
        <HeaderAndFooter>
            Product Screen
        </HeaderAndFooter>
    );
}