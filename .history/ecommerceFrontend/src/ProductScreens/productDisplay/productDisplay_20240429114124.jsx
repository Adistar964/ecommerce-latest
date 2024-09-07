import { useEffect, useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";
import Loading from "../../components/Loading"
import { backend_link } from "../../App"
import Error from "../../otherScreens/Error/Error";

// react-image-gallery => for carousel for the product
import ImageGallery from "react-image-gallery";

export default function ProductDisplay(props){
    const params = useParams()

    const [product, setProduct] = useState("");
    const [loading, setLoading] = useState(true);
    const [notFound, setNotFound] = useState(false);
    // for image carousel:
    const [images,setImages] = useState([]);
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
                    
                    // now we will set images for carousel in the specified format:
                    let imagesArray = []
                    data[0].images.map(img => imagesArray.push({original:img,thumbnail:img}))
                    setImages(imagesArray)
                    setProduct(data[0]) // we get array as response, but its first item is our product
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

    if(loading){
        return <Loading />
    }
    else if(!loading){
        if(notFound){
            return <Error /> // we will give them a 404 error
        }else{ // if product found, then we will display our page
            return(
                <HeaderAndFooter>
                    <ImageGallery  items={images} />
                </HeaderAndFooter>
            );
        }
    }
}