import { useNavigate } from "react-router-dom";
import { useEffect } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";
import { toast } from "react-toastify";

export default function () {
    const navigate = useNavigate()
    useEffect(() => {
        toast("404: page not found!")
    })
    return(
        <HeaderAndFooter>
                <div className="container border border-secondary mt-5 p-3">
                    <h3 className="text-center">
                        <i>
                            Sorry, The page you were looking for was not found!
                        </i>
                    </h3>
                    <div className="d-flex flex-column justify-content-center align-items-center mt-5 mb-5">
                        <img src="../../../public/no-results.png"
                        width={250}
                        height={250}
                        alt="no-results" />
                        <button onClick={()=>{
                            window.scrollTo(0,0); // so that it scrolls up before navigating
                            navigate("/")
                        }} 
                        className="btn btn-light border border-dark mt-4">
                            <img src="../../../public/shopping-cart.gif"
                            width={40}
                            height={40}
                            />
                            &nbsp;&nbsp;Continue Shopping&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
        </HeaderAndFooter>
    );
}