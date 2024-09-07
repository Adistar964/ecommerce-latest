
import "./productTypesList.css"
import { MdKeyboardArrowRight } from "react-icons/md";

export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex flex-wrap gap-5 mx-4">
            {props.prodTypes.map(productType => 
                <ProductTypeCard  productType={productType} />
            )}
        </div>
    )
}

function ProductTypeCard(props){
    return (
        <div className="productTypeCard card p-4 d-flex flex-row">
            <span>{props.productType}</span>
            {/* &nbsp;&nbsp;&nbsp; */}
            <MdKeyboardArrowRight size="1.5em" className="cat-arrow-right" />
        </div>
    )
}