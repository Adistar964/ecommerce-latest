
import { useNavigate } from "react-router-dom";
import "./productTypesList.css"
import { MdKeyboardArrowRight } from "react-icons/md";

export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex flex-wrap gap-5 mx-4">
            {props.prodTypes.map(productType => 
                <ProductTypeCard productType={productType} category={props.category} />
            )}
        </div>
    )
}

function ProductTypeCard(props){
    const navigate = useNavigate(); // used for navigating to another page
    return (
        <div className="productTypeCard card p-4 d-flex flex-row"
        onClick={() => navigate(`/products/${props.catgeory}/${props.productType}`)}>
            <span>{props.productType}</span>
            {/* &nbsp;&nbsp;&nbsp; */}
            <MdKeyboardArrowRight size="1.5em" className="ptype-arrow-right" />
        </div>
    )
}