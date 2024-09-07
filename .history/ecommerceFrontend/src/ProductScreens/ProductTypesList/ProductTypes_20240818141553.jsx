

// This screen will display all product-types corresponding to a category
// example: if user chose "elctronics" category, then this screen will display all
// product types corresponding to it like mobiles,laptops,etc...

import { useParams } from "react-router-dom"
import HeaderAndFooter from "../../HeaderAndFooter"
import ProductTypeCardGroup from "./ProductTypeCard"
import { useEffect, useState } from "react"
import Loading from "../../components/Loading"
import { backend_link } from "../../App"

export default function ProductTypesScreen(props) {
    
    const params = useParams()
    const category = params["category"]
    
    const [prodTypes, setProdTypes] = useState([]); // these will contain product-types fetched from backend
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        setLoading(true)
        fetch(backend_link+"/fetchAllProductTypes/"+category+"/").then(res=>res.json())
        .then(ptypes=>setProdTypes(ptypes))
        .finally(() => setLoading(false)) // after everything is done
    }, [])

    return( 
        loading ? <Loading /> :
        <HeaderAndFooter>
            <div className="m-4">
                <h4 className="text-center display-6 border border-info pt-2 pb-2 fw-lighter">
                    {category}
                </h4>
                <h5 className="mt-4 mb-2">&nbsp;&nbsp;&nbsp;Top Categories</h5>
                <ProductTypeCardGroup prodTypes={prodTypes} />
            </div>
        </HeaderAndFooter>
    )
}