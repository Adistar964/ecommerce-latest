

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header className="d-flex">
      <p className="logo-name p-2">
        964Ecommerce
        <span className="latest">
          (latest)
        </span>
      </p>
      <input type="text" placeholder="What are you searching for?"
      className="form-control srchinp" />
      <button style={{borderRadius:"2px",borderLeft:"none"}} 
      className="btn btn-theme h-100 mb-auto mt-auto">
        <i className="bi bi-search"></i>
      </button>
      <button className="btn-login h-50 align-self-center" style={{justifySelf:"flex-end"}}>
        LogIn
      </button>
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="HomeLogo">
                <i className="bi bi-house"></i> &nbsp; 
                <span>Home</span>
              </div>
              <button>groceries</button>
              <button>clothing</button>
              <button>gaming</button>
          </ul>
      </nav>
    </>
  )
}

export default Home;
