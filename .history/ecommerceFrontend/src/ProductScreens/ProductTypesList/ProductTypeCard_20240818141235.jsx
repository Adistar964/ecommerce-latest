


export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex flex-wrap">
            {props.prodTypes.map(productType => 
                <div className="mr-3">
                    <ProductTypeCard  productType={productType} />
                </div>
            )}
        </div>
    )
}

function ProductTypeCard(props){
    return (
        <div className="productTypeCard card p-2">
            {props.productType}
        </div>
    )
}