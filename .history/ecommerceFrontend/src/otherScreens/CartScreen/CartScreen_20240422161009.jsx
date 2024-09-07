
import HeaderAndFooter from "../../HeaderAndFooter";

export default function CartScreen(){
    return (
        <HeaderAndFooter>
            <div className="p-3 text-center container border border-secondary">
                <h3 style={{fontFamily:"legacy"}}>
                    YOUR CART
                </h3>
                <hr className="bg-danger mb-4" />
                <table>
                    
                </table>
            </div>
        </HeaderAndFooter>
    );
}