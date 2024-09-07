import HeaderAndFooter from "../../HeaderAndFooter";
import { useContext, useState } from "react";
import Loading from "../../components/Loading";
import { displayModal } from "../../App";
import { MyContext } from "../../configuration/context_config";
// from react-router-dom
import { useNavigate } from "react-router-dom";
// from firebase
import { auth } from "../../configuration/firebase_config";
import { signInWithEmailAndPassword, sendPasswordResetEmail,
        OAuthProvider, signInWithPopup } from "firebase/auth";
// from react-toastify
import { toast } from "react-toastify"
// from bootstrap
import { Modal } from "react-bootstrap";

export default function SignIn(){
    const navigate = useNavigate()
    const context = useContext(MyContext)

    const [loading,setLoading] = useState(false)
    const [showForgotPassModal,setshowForgotPassModal] = useState(false) // for showing a modal which asks for user email to which password reset link gets sent

    const loginUser = () => {
        setLoading(true)
        const email = document.getElementById("emaillogin").value
        const password = document.getElementById("passwordlogin").value
        signInWithEmailAndPassword(auth,email,password)
        .then(credentials=>{
            setLoading(false)
            navigate("/")
                // first dismiss all other toasts
                toast.dismiss()
                // then show ur msg
                toast.success("Welcome! successfully logged in using "+ email)
        })
        .catch(error=>{
            setLoading(false)
            if (error.message==="Firebase: Error (auth/invalid-credential)."){
                // first dismiss all other toasts
                toast.dismiss()
                // then show ur msg
                toast.error("username or password is incorrect!")
            }else{
                console.log(error)
                displayModal(context,"Couldn't log in!",
                "Please try again later!","Understood")
            }
        })
    }

    const logInWithGoogle = () => {
        setLoading(true)
        const GoogleProvider = new OAuthProvider("google.com");
        signInWithPopup(auth,GoogleProvider).then(async credentials=>{
            setLoading(false)
            navigate("/")
            displayModal(context,"Welcome!",
                        "You are logged In! You can now continue shopping with a much better experience!",
                        "Continue Shopping")
        }).catch(err=>{
            setLoading(false)
            toast.error("sorry couldnt log u in! pls try again later");
            console.error(err)
        })
    }

    // for sending a password change link but first taking user-email as input
    function sendChangePasswordLink(e){
            e.preventDefault()
            
            // extracting the email user gave
            const email = document.getElementById("emailForgotPass").value
            // for sending a password change link
            sendPasswordResetEmail( auth, email )
            .then(() => {toast("Your link has been sent! please check your inbox")})
            .catch(err => toast.error("Server error! please try again later!"))
            setshowForgotPassModal(false)
        }


    if(loading){
        return <Loading />
    }else{
        return(
            <HeaderAndFooter>
                <div className="container w-25 border border-secondary p-4 mb-5 shadow-lg">
                    <h3 className="text-center" style={{fontFamily:"fantasy"}}>
                        Login to your account
                    </h3> <br />
                    <form onSubmit={e=> {e.preventDefault();loginUser()}}>
                        <div className="form-group mb-3">
                            <label htmlFor="emaillogin">Email:</label>
                            <input required type="email" className="form-control" id="emaillogin" />
                        </div>
                        <div className="form-group mb-2">
                            <label htmlFor="passwordlogin">Password:</label>
                            <input required type="password" className="form-control" id="passwordlogin" />
                        </div>
                        <p style={{color:"blue",textDecoration:"underline",cursor:"pointer"}} 
                        onClick={()=>setshowForgotPassModal(true)} className="mb-5">
                            Forgot password?
                        </p>
                        <button className="btn btn-theme w-100">
                            Login
                        </button>
                        <p style={{fontFamily:"monospace",textAlign:"center"}} className="mt-1 mb-1">
                            Or
                        </p>
                        <button onClick={logInWithGoogle} 
                        type="button" className="google-btn">
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

                {/* This will be forgot password modal */}
                <Modal show={showForgotPassModal} onHide={()=>setshowForgotPassModal(false)}>
                    <Modal.Header closeButton>
                        <Modal.Title>Forgot Password</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <h5 className="mb-4">
                            Please Provide your corresponding email address below. 
                            <br /> <br />
                            <b><small><i>A link will be sent to your email for password change</i></small></b>
                        </h5>
                        <form onSubmit={sendChangePasswordLink}>
                            <div className="form-group mb-4">
                                <label htmlFor="emailForgotPass" className="form-label">Email</label>
                                <input type="email" required id="emailForgotPass" className="form-control" />
                            </div>
                            <div className="text-center">
                                <button className="btn btn-outline-theme" type="submit">Send</button>
                            </div>
                        </form>
                    </Modal.Body>
                </Modal>
            </HeaderAndFooter>
        );
    }
}
