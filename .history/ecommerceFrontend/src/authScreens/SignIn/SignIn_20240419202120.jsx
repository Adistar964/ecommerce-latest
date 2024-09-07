
import Header, {Footer} from "../../HeaderAndFooter";



export default function SignIn(){
    return(
        <>
            <Header />
                <div className="container w-25 border border-secondary p-4 mb-5">
                    <h3 className="text-center" style={{fontFamily:"fantasy"}}>
                        Login to your account
                    </h3> <br />
                    <form>
                        <div className="form-group">
                            <label htmlFor="usernamelogin">Username:</label>
                            <input type="text" className="form-control" id="usernamelogin" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordlogin">Password:</label>
                            <input type="text" className="form-control" id="passwordlogin" />
                        </div>
                        <button className="btn btn-theme w-100">
                            Login
                        </button>
                        <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-1 mb-1">
                            Or
                        </p>
                        <button className="btn btn-success w-100">
                            <i className="bi bi-google">&nbsp;&nbsp;Login using Google</i>
                        </button>
                    </form>
                    <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-5 mb-1">
                            Don't have an account?  
                    </p>
                    <button className="btn btn-success w-100">
                            <i className="bi bi-profile-icon">&nbsp;&nbsp;Login using Google</i>
                    </button>
                </div>
            <Footer />
        </>
    );
}