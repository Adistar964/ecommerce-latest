
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";

// from react-router-dom
import { useNavigate } from "react-router-dom";
// from firebase
import { auth } from "../../configuration/firebase_config";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { backend_link, displayModal } from "../../App";
import { useState,useContext } from "react";
import { MyContext } from "../../configuration/context_config";

export default function SignUp(){
    const navigate = useNavigate()
    const context = useContext(MyContext);
    const [loading,setLoading] = useState(false)

    // we will first create that user in firebase 
    // and then we will create that user's cart document in mongodb
    function createAccount(){
        setLoading(true)
        const email = document.getElementById("emailregister").value
        const password = document.getElementById("passwordregister").value
        const retypePassword = document.getElementById("passwordregisteragain").value
        if (password === retypePassword){
            createUserWithEmailAndPassword(auth,email,password)
            .then(async credentials => {
                const uid = credentials.user.uid
                const body = {
                    uid:uid,
                    items:[]
                }
                const requestParams = {
                    method:"POST",
                    headers:{"Content-Type":"application/json"},
                    body:JSON.stringify(body)
                }
                fetch(`${backend_link}/addCart/`,requestParams) // we will also create the user's cart documnt in mongodb
                .then(res=>res.json()).then(data=>{
                    displayModal("Welcome!",
                    `User created with email-address: "${email}" \n Now please login!`,
                    "Register",()=>{navigate("./register/")})
                }).catch(error=> {
                    setLoading(false)
                    displayModal("Server error!",
                    ` please try again later`,
                    "Ok",()=>{})
                    console.log(error)
                })
            })
            .catch(error=>{
                if (error.message==="Firebase: Error (auth/email-already-in-use)."){
                    setLoading(false)
                    displayModal(context,
                        "register error",
                        "email is already in use!\n please use other email address",
                        "Understood", ()=>{})
                }
            })
        }else{
            setLoading(false)
            displayModal(context,
                "register error",
                "The passwords dont match!\n please make sure both passwords are the same!",
                "Understood", ()=>{})
        }
    }
    if(loading){
        return <Loading />
    }else{
        return(
            <HeaderAndFooter>
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
            </HeaderAndFooter>
        );
    }
}