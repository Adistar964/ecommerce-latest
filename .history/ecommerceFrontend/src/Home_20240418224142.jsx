

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header className="row">
      <div className="logo-container row p-0 m-0">
        <img src="../public/ecommerce.png"/>
        <p className="logo-name">
            964-Ecommerce <br /> (Latest)
        </p>
      </div>
      <input type="text" className="form-control" />
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="HomeLogo">
                <i class="bi bi-house"></i> &nbsp; 
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
