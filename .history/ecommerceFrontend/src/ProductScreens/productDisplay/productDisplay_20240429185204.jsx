import { useParams } from "react-router-dom";
import { useEffect, useState, useContext } from "react";

import HeaderAndFooter from "../../HeaderAndFooter";
import Error from "../../otherScreens/Error/Error";
import Loading from "../../components/Loading"

import { MyContext } from "../../configuration/context_config";
import { backend_link, checkLoggedIn } from "../../App"
import { changeQuantity } from "../CartScreen/CartScreen";

import "./productDisplay.css";

// react-image-gallery => for carousel for the product
import ImageGallery from "react-image-gallery";
import "react-image-gallery/styles/css/image-gallery.css";

// react-icons
import { ImPriceTags } from "react-icons/im";
import { CiHeart } from "react-icons/ci";
import { FiShoppingCart } from "react-icons/fi";


export default function ProductDisplay(props){
    const params = useParams()
    const context = useContext(MyContext)
    const [product, setProduct] = useState("");
    const [loading, setLoading] = useState(true);
    const [notFound, setNotFound] = useState(true); // currently, not found
    const [quantityInCart, setQuantityInCart] = useState(false);
    // for image carousel:
    const [images,setImages] = useState([]);

    // first time adding smth to cart (similar to function in productCard.jsx)
    async function addToCart(){
        const items = [...context["cart"]]
        let exists = false;
        for (let item of items){
            if (item["product_id"] === product.product_id){
                exists = true;
                item["quantity"] ++;
            }
        }
        if (exists === false){
            items.push({
                product_id:product.product_id,
                quantity:1,
                thumbnail:product.thumbnail,
                price:product.price,
                product_name:product.title,
            })
        }
        const body = {
            update_query:{$set:{items:items}},
            uid: context["user"]["uid"]
        }
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        const response = await fetch(`${backend_link}/updateCart/`,requestParams);
        const data = await response.json()
        context.setCart(items)
    }

    // this is for initial fetching of the product
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
            fetch(`${backend_link}/getSingleProduct/`,requestParams)
            .then(res => res.json())
            .then(data => {
                if(data.length === 0){
                    setNotFound(true) // as data is not there
                }else{
                    setNotFound(false) // as data is there
                    let productFromApi = data[0];// we get array as response, but its first item is our product
                    
                    // now we will set images for carousel in the specified format:
                    let imagesArray = []
                    productFromApi.images.map(img => imagesArray.push({original:img,thumbnail:img}))
                    
                    setImages(imagesArray)
                    productFromApi["product_id"] = productFromApi["_id"] // for convinience as we wont be using it as "_id"
                    setProduct(productFromApi) 
                }
                setLoading(false)
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

    // this is for updating the quantityInCart variable
    // so that we know if the product is present in the cart or not
    // and also the product's cart_quantity
    useEffect(() => {
        // first the product must be found! => the product must be valid product
        // The user must be signed in => only that user can use cart
        if(notFound!==false && context["user"]!==null){ 
            const items = [...context["cart"]]
            let exists_in_cart = false; // by default we will assume it doesnt exist in the cart
            for(let cart_item of items){
                if(product.product_id === cart_item.product_id){ // we will find it by comparing the ids
                    exists_in_cart = true // now we found it in cart
                    setQuantityInCart(cart_item.quantity)
                }
            }
            if(!exists_in_cart){ // if its not in user's cart
                setQuantityInCart(0)
                // see html for "add to cart btn"
            }
        }
    }, [context["cart"],product])

    if(loading){
        return <Loading />
    }
    else if(!loading){
        if(notFound){
            return <Error /> // we will give them a 404 error
        }else{ // if product found, then we will display our page
            return(
                <HeaderAndFooter>
                    <div className="d-flex mt-4 justify-content-between mr-3">
                        <ImageGallery  items={images}
                        infinite autoPlay additionalClass="p-5 pt-1" 
                        showPlayButton={false}
                        thumbnailPosition="bottom"
                        onImageLoad={()=>setLoading(false)} />
                        <div className="text-center flex-grow-1 pt-1">
                            <div className="border p-3">
                                <h3 style={{fontFamily:"monospace",textAlign:"center"}}>
                                    {product.title}
                                </h3>
                                <p style={{fontFamily:"monospace"}}>
                                    Brand: {product.brand}
                                </p>
                                <h5>
                                    <del className="text-secondary d-block">
                                        {product.discountPrice}
                                    </del> <br />
                                    &nbsp;<ImPriceTags /> &nbsp;
                                    {product.price}
                                </h5>
                                <hr />
                                {quantityInCart === 0 ?
                                <button onClick={()=>checkLoggedIn(context,()=>s)}
                                style={{width:"100%"}}
                                className="btn btn-outline-theme">
                                    <FiShoppingCart  size="1.5em" />
                                    &nbsp;&nbsp;Add to Cart
                                </button>    :
                                <button onClick={()=>checkLoggedIn(context,()=>s)}
                                style={{width:"100%"}}
                                className="btn btn-outline-theme">
                                    <FiShoppingCart  size="1.5em" />
                                    &nbsp;&nbsp;{product["product_id"]}
                                </button>
                            }
                                <button style={{width:"100%"}}
                                className="btn btn-outline-danger mt-3">
                                    <CiHeart  size="1.8em" />
                                    &nbsp;Add to Favourites
                                </button>
                            </div>
                        </div>
                    </div>
                </HeaderAndFooter>
            );
        }
    }
}