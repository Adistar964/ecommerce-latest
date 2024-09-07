import HeaderAndFooter from "../../HeaderAndFooter";
import { useParams } from "react-router-dom";

export default function ProductDisplay(props){
    const params = useParams()
    console.log(params)
    return(
        <HeaderAndFooter>
            Product Screen
        </HeaderAndFooter>
    );
}