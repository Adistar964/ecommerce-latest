


export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex flex-wrap gap-5 mx-xxl-4">
            {props.prodTypes.map(productType => 
                <ProductTypeCard  productType={productType} />
            )}
        </div>
    )
}

function ProductTypeCard(props){
    return (
        <div className="productTypeCard card p-4">
            {props.productType}
        </div>
    )
}