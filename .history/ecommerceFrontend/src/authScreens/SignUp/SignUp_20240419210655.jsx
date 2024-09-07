
import Header, {Footer} from "../../HeaderAndFooter";

// from react-router-dom
import { useNavigate } from "react-router-dom";
// from firebase
import { auth } from "../../configuration/firebase_config";
import { createUserWithEmailAndPassword } from "firebase/auth";

export default function SignUp(){
    const navigate = useNavigate()

    function createAccount(){
        const email = document.getElementById("emailregister").value
        const password = document.getElementById("passwordregister").value
        const retypePassword = document.getElementById("passwordregisteragain").value
        if (password === retypePassword){
            createUserWithEmailAndPassword(auth,email,password)
            .then(credentials => {alert("User created with email:",credentials.user.email);navigate("/login/")})
            .catch(error=>{
                if (error.message==="Firebase: Error (auth/email-already-in-use)."){
                    alert("email address is already in use")
                }
            })
        }else{
            alert("The passwords dont match!")
        }
    }

    return(
        <>
            <Header />
                <div className="container w-25 border border-secondary p-4 mb-5">
                    <h3 className="text-center" style={{fontFamily:"fantasy"}}>
                        Register An Account
                    </h3> <br />
                    <form onSubmit={e=>{e.preventDefault();createAccount()}}>
                        <div className="form-group">
                            <label htmlFor="emailregister">Email:</label>
                            <input required type="email" className="form-control" id="emailregister" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordregister">Password:</label>
                            <input required type="password" minLength={8}
                             className="form-control" id="passwordregister" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordregisteragain">Retype Password:</label>
                            <input required type="password" minLength={8}
                             className="form-control" id="passwordregisteragain" />
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