


export default function ProductTypeCardGroup(props){
    return (
        <div className="p-2 d-flex no-wrap">
            <ProductTypeCard productType="something hh" />
        </div>
    )
}

export default function ProductTypeCard(props){
    return (
        <div className="productTypeCard card p-2">
            {props.productType}
        </div>
    )
}