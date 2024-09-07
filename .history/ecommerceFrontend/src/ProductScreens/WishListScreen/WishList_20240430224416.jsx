
import { currency,backend_link, displayModal } from "../../App";
import { useContext, useState, useEffect } from "react";
import { MyContext } from "../../configuration/context_config";
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";
import { ToggleFavourites } from "./WishListFunction";

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
        if(emptyWishList){ // if wish-list not there(empty)
            return(
                <HeaderAndFooter>
                    Empty!!
                </HeaderAndFooter>
            );
        }else if(!emptyWishList){ // if wish-list available(not empty)
            return(
                <HeaderAndFooter>
                    <div className="p-3 text-center container border border-secondary">
                        <div className="d-flex">
                            <h3 style={{fontFamily:"san-serif",flexGrow:1}}>
                                WISH-LIST
                            </h3>
                            <a href="" 
                            // onClick={clearCartClick}
                            style={{display:"inline",cursor:"pointer"}}>
                                Clear WishList
                            </a>
                        </div>
                        <hr className="bg-danger mb-4" />
                        <ul style={{listStyle:"none"}}>
                            {context["favourites"].map(item => 
                            <li style={{justifyContent:"space-between", cursor:"pointer",transition:"all 0.5s"}} 
                            className="w-100 border d-flex p-3 align-items-center cart-item-hover">
                                <input style={{transform:"scale(1.5)"}}  // basically increasing its size
                                type="checkbox" />
                                <img onClick={()=>navigate("/product/"+item.product_id)} 
                                src={item.thumbnail} className="cart-img"
                                style={{cursor:"pointer"}} />
                                <h5 onClick={()=>navigate("/product/"+item.product_id)} 
                                style={{width:"250px",cursor:"pointer"}}>
                                    {item.product_name}
                                </h5>
                                <div className="border p-3 d-flex ml-3 align-items-center justify-content-center">
                                <button 
                                // onClick={()=>changeQuantity(item,"subtract",context)} 
                                    className="btn btn-outline-theme"
                                    disabled={item["quantity"]===1}>
                                        -
                                    </button>
                                    <button className="btn text-dark">
                                        1
                                    </button>
                                    <button 
                                    // onClick={()=>changeQuantity(item,"add",context)} 
                                    className="btn btn-outline-theme">
                                        +
                                    </button>
                                </div>
                                <div className="ml-3 mr-3">
                                    <p>QAR <b>{item.price}</b></p>
                                </div>
                                <div className="d-flex justify-content-end">
                                    <button 
                                    onClick={()=>
                                    displayModal(context,"Remove from wishlist",
                                "Do you want to proceed removing '"+item["product_name"]+"' from the wishlist?",
                                "remove",()=>ToggleFavourites(context,item))
                                    } 
                                    style={{borderRadius:"5px"}} 
                                    className="btn btn-danger">
                                        <i className="bi bi-trash"></i>
                                    </button>
                                </div>
                            </li>
                            )}
                        </ul>
                        <hr />
                        <div className="text-center">
                            <button onClick={() => navigate("/order")} 
                            className="btn btn-outline-success" disabled={true}>
                                <i className="bi bi-basket" style={{fontSize:"1.3em"}}>
                                    &nbsp;&nbsp;Add to Cart&nbsp;&nbsp;
                                </i>
                            </button>
                        </div>
                    </div>
                </HeaderAndFooter>
            );
        }
    }

}