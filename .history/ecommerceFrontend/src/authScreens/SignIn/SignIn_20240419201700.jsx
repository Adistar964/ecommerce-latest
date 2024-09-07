
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
                        </button> <br /><br />
                        <p style={{fontFamily:"monospace",textAlign:"center"}}>
                            Or
                        </p>
                        <button className="btn btn-success w-100">
                        <svg class="bi" aria-hidden="true"><use xlink:href="#arrow-right"></use></svg>
                            Login using Google
                        </button>
                    </form>
                </div>
            <Footer />
        </>
    );
}