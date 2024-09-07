

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header className="row">
      <div className="logo-container col">
        <img src="../public/ecommerce.png"/>
        <p className="logo-name d-inline">
            964-Ecommerce <br /> (Latest)
        </p>
      </div>
      <div className="col">
        <input type="text" className="form-control w-100" />
      </div>
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
