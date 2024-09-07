

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
        <div className="text-center">
            <h4 className="display-6 border border-black pt-2 pb-2 m-4">
                {category}
            </h4>
            <h5>Top Categories</h5>
        </div>
    </HeaderAndFooter>
    )
}