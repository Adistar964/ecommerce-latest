
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
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-add" viewBox="0 0 16 16">
  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
  <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
</svg>
                            <i className="bi bi-person-add">&nbsp;&nbsp;Register an account</i>
                    </button>
                </div>
            <Footer />
        </>
    );
}