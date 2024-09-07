


export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex flex-wrap">
            {props.prodTypes.map(productType => 
                <ProductTypeCard  productType={productType} />
            )}
        </div>
    )
}

function ProductTypeCard(props){
    return (
        <div className="productTypeCard card p-2 mr-5">
            {props.productType}
        </div>
    )
}