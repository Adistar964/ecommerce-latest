import HeaderAndFooter from "../../HeaderAndFooter";

// from react-router-dom
import { useNavigate } from "react-router-dom";
// from firebase
import { auth } from "../../configuration/firebase_config";
import { signInWithEmailAndPassword } from "firebase/auth";
import { useState } from "react";
import Loading from "../../components/Loading";

export default function SignIn(){
    const navigate = useNavigate()

    const [loading,setLoading] = useState(false)

    const loginUser = () => {
        setLoading(true)
        const email = document.getElementById("emaillogin").value
        const password = document.getElementById("passwordlogin").value
        signInWithEmailAndPassword(auth,email,password)
        .then(credentials=>{
            setLoading(false)
            alert(`successfully logged in using ${email}`)
            navigate("/")
        })
        .catch(error=>{
            setLoading(false)
            if (error.message==="Firebase: Error (auth/invalid-credential)."){
                alert("username or password is incorrect")
            }
        })
    }
    if(loading){
        return <Loading />
    }else{
        return(
            <HeaderAndFooter>
                <div className="container w-25 border border-secondary p-4 mb-5">
                    <h3 className="text-center" style={{fontFamily:"fantasy"}}>
                        Login to your account
                    </h3> <br />
                    <form onSubmit={e=> {e.preventDefault();loginUser()}}>
                        <div className="form-group">
                            <label htmlFor="emaillogin">Email:</label>
                            <input required type="email" className="form-control" id="emaillogin" />
                        </div>
                        <div className="form-group">
                            <label htmlFor="passwordlogin">Password:</label>
                            <input required type="password" className="form-control" id="passwordlogin" />
                        </div>
                        <button className="btn btn-theme w-100">
                            Login
                        </button>
                        <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-1 mb-1">
                            Or
                        </p>
                        <button type="button" className="google-btn">
                            <img style={{height:"30px",width:"30px"}} 
                            src="../../../public/googleLogo.png" />
                            <p style={{margin:"auto",marginLeft:"5px"}}>
                                Sign In with Google
                            </p>
                        </button>
                    </form>
                    <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-5 mb-1">
                            Don't have an account?  
                    </p>
                {/* This will navigate us to that register-page */}
                    <button onClick={()=>{navigate("/register/")}} 
                    className="btn btn-outline-theme w-100">
                            &nbsp;&nbsp;Register an account
                    </button>
                </div>
            </HeaderAndFooter>
        );
    }
}
