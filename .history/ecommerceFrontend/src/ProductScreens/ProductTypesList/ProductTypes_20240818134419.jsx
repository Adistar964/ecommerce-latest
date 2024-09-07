

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
        <div className="mt-2">
            <h4 className="text-center display-6 border border-black pt-2 pb-2">
                {category}
            </h4>
        </div>
    </HeaderAndFooter>
    )
}