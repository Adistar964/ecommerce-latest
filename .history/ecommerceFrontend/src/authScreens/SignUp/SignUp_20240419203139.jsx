
import Header, {Footer} from "../../HeaderAndFooter";
import { useNavigate } from "react-router-dom";

export default function SignUp(){
    const navigate = useNavigate()
    return(
        <>
            <Header />
                <div className="container w-25 border border-secondary p-4 mb-5">
                    <h3 className="text-center" style={{fontFamily:"fantasy"}}>
                        Register An Account
                    </h3> <br />
                    <form>
                        <div className="form-group">
                            <label htmlFor="emailregister">email:</label>
                            <input type="email" className="form-control" id="emailregister" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordregister">Password:</label>
                            <input type="text" className="form-control" id="passwordregister" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordregisteragain">Retype Password:</label>
                            <input type="text" className="form-control" id="passwordregisteragain" />
                        </div>
                        <button className="btn btn-theme w-100">
                            Register
                        </button>
                        <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-1 mb-1">
                            Or
                        </p>
                        <button className="btn btn-success w-100">
                            <i className="bi bi-google">&nbsp;&nbsp;Register using Google</i>
                        </button>
                    </form>
                    <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-5 mb-1">
                            Already have an account?  
                    </p>
                    <button onClick={()=>{navigate("/login/")}} 
                    className="btn btn-outline-theme w-100">
                            &nbsp;&nbsp;Sign In
                    </button>
                </div>
            <Footer />
        </>
    );
}