
import { currency,backend_link } from "../../App";
import { useContext, useState, useEffect } from "react";
import { MyContext } from "../../configuration/context_config";
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";

export default function WishList(props){

    const [emptyWishList,setEmptyWishList] = useState(true)
    const [loading, setLoading] = useState(true)
    const context = useContext(MyContext)

    // fetching all user's favourites
    useEffect(() => {
        setLoading(true)
        // our user must be signed-in and must have somehting in the wishlist
        // otherwise the empty-wish-list component will be rendered 
        if(context["user"]!==null && context["favourites"].length!==0){
            setEmptyWishList(false)
        }else {
            setEmptyWishList(true)
        }
        setLoading(false)
    },[context["favourites"]])

    if(loading){
        return <Loading />
    }else{
        if(emptyWishList){
            return(
                <HeaderAndFooter>
                    Empty!!
                </HeaderAndFooter>
            );
        }
    }

}