
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


// this will be for mongodb and firebase data to be loaded
export function MainScreenLoading(){
    return(
        <div style={{height:"100vh"}} 
        className="d-flex align-items-center justify-content-center">
            <div className="spinner-border"></div>
        </div>
    );
}