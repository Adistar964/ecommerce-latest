

// This screen will display all product-types corresponding to a category
// example: if user chose "elctronics" category, then this screen will display all
// product types corresponding to it like mobiles,laptops,etc...

export default function ProductTypesScreen(props) {
    
    const params = useParams()
    const category = params["category"]
    
    return( 
    <div className="mt-2 border-top">
        heyy {category}   
    </div>
    )
}