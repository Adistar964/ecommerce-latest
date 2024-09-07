

// This screen will display all product-types corresponding to a category
// example: if user chose "elctronics" category, then this screen will display all
// product types corresponding to it like mobiles,laptops,etc...

import { useParams } from "react-router-dom"
import HeaderAndFooter from "../../HeaderAndFooter"

export default function ProductTypesScreen(props) {
    
    const params = useParams()
    const category = params["category"]
    
    return( 
    <HeaderAndFooter>
        <div className="m-4">
            <h4 className="text-center display-6 border border-warning pt-2 pb-2">
                {category}
            </h4>
            <h5 className="mt-4">Top Categories</h5>
        </div>
    </HeaderAndFooter>
    )
}