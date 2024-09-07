

// This screen will display all product-types corresponding to a category
// example: if user chose "elctronics" category, then this screen will display all
// product types corresponding to it like mobiles,laptops,etc...

import { useParams } from "react-router-dom"

export default function ProductTypesScreen(props) {
    
    const params = useParams()
    const category = params["category"]
    
    return( 
    <HeaderAndFooter>
        <div className="mt-2 border-top">
            heyy {category}
        </div>
    </HeaderAndFooter>
    )
}