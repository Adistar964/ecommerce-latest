
import HeaderAndFooter from "../HeaderAndFooter";

export default function Loading(){
    return (
        <HeaderAndFooter>
            <div style={{height:"100vh"}} 
            className="d-flex align-items-center justify-content-center">
                <div className="spinner-border"></div>
            </div>
        </HeaderAndFooter>
    );
}