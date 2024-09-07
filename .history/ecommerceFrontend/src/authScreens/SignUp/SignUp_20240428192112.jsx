
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading";

// from react-router-dom
import { useNavigate } from "react-router-dom";
// from firebase
import { auth } from "../../configuration/firebase_config";
import { createUserWithEmailAndPassword, 
        OAuthProvider, signInWithPopup} from "firebase/auth";
import { backend_link, displayModal } from "../../App";
import { useState,useContext } from "react";
import { MyContext } from "../../configuration/context_config";

// importing our css
import "./signUp.css";

export default function SignUp(){
    const navigate = useNavigate()
    const context = useContext(MyContext);
    const [loading,setLoading] = useState(false)

    // we will first create that user in firebase 
    // and then we will create that user's cart document in mongodb
    function createAccount(){
        const email = document.getElementById("emailregister").value
        const password = document.getElementById("passwordregister").value
        const retypePassword = document.getElementById("passwordregisteragain").value
        setLoading(true)
        if (password === retypePassword){
            createUserWithEmailAndPassword(auth,email,password)
            .then(async credentials => {
                const uid = credentials.user.uid
                addCartAfterRegistering(uid,email)
            })
            .catch(error=>{
                if (error.message==="Firebase: Error (auth/email-already-in-use)."){
                    setLoading(false)
                    displayModal(context,
                        "register error",
                        "email is already in use!\n please use other email address",
                        "Understood")
                }else {
                    setLoading(false)
                    displayModal(context,
                        "server error!",
                        "We are currently facing issues, please try again later.",
                        "Continue Shopping", ()=>{navigate("/")})
                }
            })
        }else{
            setLoading(false)
            displayModal(context,
                "register error",
                "The passwords dont match!\n please make sure both passwords are the same!",
                "Understood")
        }
    }

    const createAccountWithGoogle = () => {
        setLoading(true)
        const GoogleProvider = new OAuthProvider("google.com");
        signInWithPopup(auth,GoogleProvider).then(async credentials=>{
            const uid = credentials.user.uid;
            const email = credentials.user.email;
            console.log(uid)
            addCartAfterRegistering(uid,email)
        }).catch(err=>console.log(err))
    }

    const addCartAfterRegistering = (uid,email) => {
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
            setLoading(false)
            context["setCart"]([])
            navigate("/")
            displayModal(context,"Welcome!",
            `your account was successfully created with email-address: "${email}"`,
            "Continue shopping")
        }).catch(error=> {
            setLoading(false)
            displayModal(context,"error registering the account!",
            ` please try again later`,
            "Ok")
            console.weeoe(error)
        })
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
                        <div className="form-group mb-3">
                            <label htmlFor="emailregister">Email:</label>
                            <input required type="email" className="form-control" id="emailregister" />
                        </div>
                        <div className="form-group mb-3">
                            <label htmlFor="passwordregister">Password:</label>
                            <input required type="password" minLength={8}
                                className="form-control" id="passwordregister" />
                        </div>
                        <div className="form-group mb-5">
                            <label htmlFor="passwordregisteragain">Retype Password:</label>
                            <input required type="password" minLength={8}
                                className="form-control" id="passwordregisteragain" />
                        </div>
                        <button type="submit" className="btn btn-theme w-100">
                            Register
                        </button>
                        <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-1 mb-1">
                            Or
                        </p>
                        <button onClick={createAccountWithGoogle}
                        type="button" className="google-btn">
                            <img style={{height:"30px",width:"30px"}} 
                            src="https://developers.google.com/identity/images/g-logo.png" />
                            <p style={{margin:"auto",marginLeft:"5px"}}>
                                Register with Google
                            </p>
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