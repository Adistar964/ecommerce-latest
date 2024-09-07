
import HeaderAndFooter from "../../HeaderAndFooter"
import "./Profile.css"

import { useContext } from "react"
import { MyContext } from "../../configuration/context_config"

import { auth } from "../../configuration/firebase_config"
import { signOut, sendPasswordResetEmail, deleteUser } from "firebase/auth"

import { useNavigate,Navigate } from "react-router-dom"

import { displayModal } from "../../App"
import { toast } from "react-toastify"

// react-icons
import { BsBoxSeam,BsBagCheckFill,
        BsBoxArrowInRight,BsBookmarkHeart }
        from "react-icons/bs";
import { RiLockPasswordLine, RiMailFill } from "react-icons/ri";
import { LuUserMinus } from "react-icons/lu";

export default function Profile(){
    const navigate = useNavigate()

    // getting context-data
    const context = useContext(MyContext)
    // accessing current user
    const user = context["user"]

    // for logout
    function logout(){
        displayModal(context, "Sign Out",
    "Are you sure you want to sign out?","Logout", ()=>{
        signOut(auth).then(response=>{
            // now itll navigate us to login page as our user is now null
            navigate("/login/")
        })  
    })
    }

    // for sending a password change link but first cnfirming it
    function confirmPasswordChangeLink(){

        // for sending a password change link
        function sendPasswordChangeLink(){
            sendPasswordResetEmail( auth, context["user"]["email"] )
            .then(() => {navigate("/login/");toast("Your link has been sent! please check your inbox")})
            .catch(err => toast.error("Server error! please try again later!"))
        }

        // confirming if user wants to send a link
        displayModal(context,"Password Reset",
        "For changing your password, you will be sent a link at your current email.",
        "send",sendPasswordChangeLink)

    }

    // for deletung that user but first cnfirming it
    function confirmDeleteUser(){

        // for sending a password change link
        function deleteUserPermanently(){
            toast.info("not now")
        }

        // confirming if user wants to send a link
        displayModal(context,"Delete Account Permanently",
        "If you are looking for a signing out, this is not the right option. Deleting Your account will delete all its data permanently and it cant be undone.",
        "Confirm Delete",deleteUserPermanently)

    }

    if (user !== null){ // if user is signed in!
        return(
            <HeaderAndFooter>   
                    <h3 className="text-center mt-3 mb-3 display-5">
                        Profile Page
                    </h3>
                <div style={{maxWidth:"700px"}} 
                className="container border border-secondary shadow-lg p-4">
                    <div className="form-group mb-4 mt-3">
                        <label htmlFor="emailprofile">email</label>
                        <input type="email" value={user["email"]} 
                        className="form-control" disabled />
                    </div>
                    {user["providerData"][0]["providerId"] === "password" ? 
                        <div className="form-group">
                            <label htmlFor="emailprofile">password</label>
                            <input type="password" value="aaaaaaaaaaaaaaaaaaaaaaa" 
                            className="form-control" disabled />
                        </div>  : 
                        <div className="form-group">
                            <label htmlFor="emailprofile">Login Provider</label>
                            <input type="text" value={user["providerData"][0]["providerId"]} 
                            className="form-control" disabled />
                        </div>
                        }
                    <br />  
                    <hr />
                    <h3 className="subheading-profile">Activities</h3>
                    <div className="d-flex flex-nowrap gap-2 justify-content-evenly">
                        <button 
                        onClick={()=>navigate("/orderlist/")}
                        className="btn btn-outline-success mb-4 mt-4">
                            <BsBoxSeam size="1.3em" />
                            &nbsp;&nbsp;My Orders&nbsp;&nbsp;
                        </button>
                        <button 
                        onClick={()=>navigate("/cart/")}
                        className="btn btn-outline-theme mb-4 mt-4">
                            <BsBagCheckFill size="1.2em" className="mb-1" /> 
                            &nbsp;&nbsp;My Cart&nbsp;&nbsp;
                        </button>
                        <button 
                        onClick={()=>navigate("/wishlist/")}
                        className="btn btn-outline-Fuchsia mb-4 mt-4">
                            <BsBookmarkHeart  size="1.3em" />
                            &nbsp;&nbsp;Wish List&nbsp;&nbsp;
                        </button>
                    </div>
                    <hr />
                    <h3 className="subheading-profile">Actions</h3>
                    <div className="d-flex flex-nowrap gap-2 justify-content-evenly">
                        {/* Only chnage password if u have emailPassword type account */}
                        {user["providerData"][0]["providerId"] !== "google.com" ? 
                            <>
                                <button
                                onClick={()=>navigate("/cart/")}
                                className="btn btn-outline-MediumSlateBlue mb-4 mt-4">
                                    <RiMailFill size="1.2em" className="mb-1" />
                                    &nbsp;&nbsp;Change Email&nbsp;&nbsp;
                                </button>
                                <button 
                                onClick={confirmPasswordChangeLink}
                                className="btn btn-outline-CornflowerBlue mb-4 mt-4">
                                    <RiLockPasswordLine size="1.3em" />
                                    &nbsp;&nbsp;Change Password&nbsp;&nbsp;
                                </button>
                            </>
                        : "" }
                        <button 
                        onClick={logout}
                        className="btn btn-outline-Salmon mb-4 mt-4">
                            <BsBoxArrowInRight  size="1.3em" />
                            &nbsp;&nbsp;Logout&nbsp;&nbsp;
                        </button>
                    </div>
                    <hr className="mt-5" />
                    <div className="text-center">
                        <button onClick={confirmDeleteUser} 
                        className="btn btn-outline-danger">
                            <LuUserMinus size="1.3em" />
                            &nbsp;&nbsp;&nbsp;Delete Account
                        </button>
                    </div>
                </div>
            </HeaderAndFooter>
            )
    }else{
        // dont do navigate() but do:
        <Navigate to="/login/" />
    }
}