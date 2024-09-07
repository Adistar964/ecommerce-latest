
import { currency,backend_link } from "../../App";
import { useContext, useState, useEffect } from "react";
import { MyContext } from "../../configuration/context_config";
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";

export default function WishList(props){

    const [favProds,setFavProds] = useState([])
    const [loading, setLoading] = useState(true)
    const context = useContext(MyContext)

    if(loading){
        return <Loading />
    }else{
        return
        <HeaderAndFooter>
            
        </HeaderAndFooter>
    }

}